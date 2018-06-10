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

def init_spreadsheet
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[1]
  title = ['Rank country', 'Rank international', 'Name', 'Team', 'Character', 'Actual score', 'Number of tournament', 'Country']
  title.each_with_index { |title_value, index| ws[1, index + 1] = title_value }
  ws
end

def save_excel(spreadsheet)
  spreadsheet.save
  spreadsheet.reload
end

# Create a Spreadsheet on google drive
def data_to_excel(player_hash)
  ws = init_spreadsheet
  (2..player_hash['tr_index_country'].length).each_with_index do |row, index|
    8.times do |i|
      ws[row, i + 1] = player_hash[player_hash.keys[i]][index]
    end
  end
  save_excel(ws)
end

# Scrap the infos
def scrap(url, browser, _game, _style)
  player = {
    'tr_index_country' => [],
    'tr_index_inter' => [],
    'tr_name' => [],
    'tr_team' => [],
    'tr_character' => [],
    'tr_actual_score' => [],
    'tr_tournament' => [],
    'tr_country' => []
  }

  browser.goto url

  # Get the datas
  # I don't create a function if the call is one line
  content_to_scrapp = browser.tables(class: %w[table table-striped table-hover table-condensed])
  content_to_scrapp.each do |table|
    table.each_with_index do |row, index|
      next if index.zero?
      row.each_with_index do |col, index|
        case index
        when 0
          player['tr_index_country'] << col.text
        when 1
          player['tr_index_inter'] << col.text
        when 2
          player['tr_name'] << col.text
        when 3
          player['tr_team'] << col.text
        when 4
          player['tr_character'] << col.text
        when 5
          player['tr_actual_score'] << col.text
        when 6
          player['tr_tournament'] << col.text
        when 7
          player['tr_country'] << col.text
        else
          next
        end
      end
    end
  end
  data_to_excel(player)
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
  scrap(url, browser, my_game, style)
end

main
