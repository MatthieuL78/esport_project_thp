# frozen_string_literal: true

require 'watir'
require 'google_drive'

# Check if a string is an integer
class String
  def i?
    !!(self =~ /\A[-+]?[0-9]+\z/)
  end
end

# Create my url
def my_url(country, game)
  'http://rank.shoryuken.com/rankings/rank?country=' + country + '&pchar=any+character&rankingType=ACTUAL&_filtermain=&id=' + game
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
  # I don't create a function if the call is one line
  title = browser.divs(class: 'TournamentCardHeading__title')
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

# Scraping data on smash GG for : Tournament
# Datas : Tournament : Name - Date - Image - place - nb of attendees
# Data fill manually : Style - Game
# Choose your game : Tekken 7, Street fighter

# Make a table with all the game's name to scrap

def main
  # Add the following information :
  my_game = 'T7'
  style = 'combat'
  my_country = 'france'
  # End
  
  url = my_url(my_country, my_game)
  browser = Watir::Browser.new :firefox
  scrap(url, browser, game, style)
  
end
