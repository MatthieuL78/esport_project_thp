# frozen_string_literal: true

require 'watir'
require 'google_drive'

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
  game = 'Street fighter'
  my_page = '&page=' + page
  url_first_part + nb_per_page + url_second_part + game + my_page
end

def init_spreadsheet
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[0]
  title = ['Title', 'Image', 'Date', 'Attend', 'Place', 'Game', 'Style']
  title.each_with_index { |title_value, index| ws[1, index + 1] = title_value }
  ws
end

def save_excel(spreadsheet)
  spreadsheet.save
  spreadsheet.reload
end

# Create a Spreadsheet on google drive
def data_to_excel(tournament_hash)
  ws = init_spreadsheet
  (@my_data..@my_data + tournament_hash['tr_title'].length).each_with_index do |row, index|
    tournament_hash.size.times do |i|
      ws[row, i + 1] = tournament_hash[tournament_hash.keys[i]][index]
    end
  end
  save_excel(ws)
  @my_data += tournament_hash['tr_title'].length
end

# Scrap the infos
def scrap(url, browser, game, style, nb_of_event)
  title = ''
  tournament = {
    'tr_title' => [],
    'tr_image' => [],
    'tr_date' => [],
    'tr_attend' => [],
    'tr_place' => [],
    'tr_game' => [],
    'tr_style' => []
  }

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
  tournament['tr_title'] = title.map(&:text)

  img.each do |div|
    if div.image.exists?
      tournament['tr_image'] << div.image.src
    else
      tournament['tr_image'] << ''
    end
  end

  tournament['tr_date'] = date.map(&:text)

  # To improve
  tournament['tr_attend'] = attend_place.map do |div|
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
  tournament['tr_place'] = attend_place.map do |div|
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
  tournament['tr_title'].length.times do
    tournament['tr_game'] << game.capitalize
    tournament['tr_style'] << style.capitalize
  end

  data_to_excel(tournament)
end

# Scraping data on smash GG for : Tournament
# Datas : Tournament : Name - Date - Image - place - nb of attendees
# Data fill manually : Style - Game
# Choose your game : Tekken 7, Street fighter

# Make a table with all the game's name to scrap

def main
  # Add the following information :
  my_game = 'Street fighter'
  style = 'Combat'
  # End

  @my_data = 2
  my_page = 0

  browser = Watir::Browser.new :firefox

  my_nb_event = nb_of_event(browser, first_url(my_game))
  @nb_event_integer = my_nb_event.to_i

  while @nb_event_integer.positive?
    my_nb_event = '100'
    my_page += 1
    @nb_event_integer -= 100
    url = my_url(my_nb_event, my_page.to_s)
    scrap(url, browser, my_game, style, my_nb_event.to_i)
  end
end

main