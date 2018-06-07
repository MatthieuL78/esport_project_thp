# frozen_string_literal: true

require 'watir'
require 'open-uri'
require 'google_drive'
require 'byebug'

# Scraping data on smash GG for : Tournament
# Datas : Tournament : Name - Date - Image - place - nb of attendees
# Data fill manually : Style - Game
# Choose your game : Tekken 7, Street fighter
my_game = 'street fighter'
@my_data = 2

# Make a table with all the game's name to scrap

# Check if a string is an integer
class String
  def i?
    !!(self =~ /\A[-+]?[0-9]+\z/)
  end
end

# First URL to get all events
def first_url(game)
  'https://smash.gg/tournaments?filter=' + game
end

# Get the number of event
def nb_of_event(browser, url)
  browser.goto url
  item = browser.p(class: 'text-muted').text
  table_of_item = item.split('').reverse_each.take_while do |letter|
    letter != ' '
  end
  table_of_item.reverse.join('')
end

# Create my url
def my_url(nb_of_event, page)
  url_first_part = 'https://smash.gg/tournaments?per_page='
  nb_per_page = nb_of_event
  url_second_part = '&filter='
  game = 'street fighter'
  my_page = '&page=' + page
  url_first_part + nb_per_page + url_second_part + game + my_page
end

# Create a Spreadsheet on google drive
def save_data_on_spreadsheet(title, img, date, attend, place, game, style)
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[0]
  ws[1, 1] = 'Title'
  ws[1, 2] = 'Image'
  ws[1, 3] = 'Date'
  ws[1, 4] = 'Attend'
  ws[1, 5] = 'Place'
  ws[1, 6] = 'Game'
  ws[1, 7] = 'Style'

  (@my_data..@my_data + title.length).each_with_index do |row, index|
    ws[row, 1] = title[index]
    ws[row, 2] = img[index]
    ws[row, 3] = date[index]
    ws[row, 4] = attend[index]
    ws[row, 5] = place[index]
    ws[row, 6] = game[index]
    ws[row, 7] = style[index]
  end
  ws.save
  ws.reload
  @my_data += title.length
end

# Scrap the infos
def scrap(url, browser, game, style, nb_of_event)
  tr_img = []
  tr_style = []
  tr_game = []
  title = ''

  browser.goto url

  # Get the datas
  if @nb_event_integer >= 0
    while title.length != nb_of_event
      title = browser.divs(class: 'TournamentCardHeading__title')
      sleep(1)
    end
  elsif @nb_event_integer.negative?
    while title.length != @nb_event_integer + 100
      title = browser.divs(class: 'TournamentCardHeading__title')
      sleep(1)
    end
  end

  # I don't create a function if the call is one line
  img = browser.divs(class: %w[TournamentCardIcon undefined])
  date = browser.divs(class: 'TournamentCardHeading__information')
  attend_place = browser.divs(class: 'TournamentCardContainer')

  # Save in 3 differents tables
  img.each do |div|
    if div.image.exists?
      tr_img << div.image.src
    else
      tr_img << ''
    end
  end

  tr_title = title.map(&:text)

  tr_date = date.map(&:text)

  # To improve
  tr_attend = attend_place.map do |div|
    my_result = div.divs(class: %w[InfoList__title InfoList__section]).map do |divbis|
      if divbis.a.exists?
        my_text = divbis.a.text.split('').take_while do |text|
          text != ' '
        end
        my_text.join('')
      end
    end
    if my_result[0].nil?
      ' '
    else
      my_result[0]
    end
  end

  # To improve
  tr_place = attend_place.map do |div|
    my_result = div.divs(class: %w[InfoList__title InfoList__section]).map do
      if div.children[1].text[0].i? || div.children[1].text[0].nil?
        'ONLINE'
      else
        div.children[1].span.text
      end
    end
    if my_result[0].nil?
      'ONLINE'
    else
      my_result[0]
    end
  end

  # Put this in an other function
  title.length.times do
    tr_game << game.capitalize
    tr_style << style.capitalize
  end

  save_data_on_spreadsheet(tr_title, tr_img, tr_date, tr_attend, tr_place, tr_game, tr_style)
end

# Create main function
browser = Watir::Browser.new :firefox

my_nb_event = nb_of_event(browser, first_url(my_game))
@nb_event_integer = my_nb_event.to_i

my_my_page = 0

while @nb_event_integer.positive?

  my_nb_event = '100'
  my_my_page += 1
  @nb_event_integer -= 100

  url = my_url(my_nb_event, my_my_page.to_s)
  game = 'street fighter'
  style = 'combat'
  scrap(url, browser, game, style, my_nb_event.to_i)

end