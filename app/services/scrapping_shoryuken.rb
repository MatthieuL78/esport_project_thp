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

def init_spreadsheet(worksheet_hash)
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key(worksheet_hash['ws_url']).worksheets[worksheet_hash['ws_num']]
  worksheet_hash['titles'].each_with_index { |title_value, index| ws[1, index + 1] = title_value }
  ws
end

def save_excel(spreadsheet)
  spreadsheet.save
  spreadsheet.reload
end

# Add data on spreadsheet
def data_to_excel(data_hash, worksheet_hash)
  ws = init_spreadsheet(worksheet_hash)
  (2..data_hash[data_hash.keys[0]].length + 2).each_with_index do |col, index|
    worksheet_hash['titles'].length.times do |i|
      ws[col, i + 1] = data_hash[data_hash.keys[i]][index]
    end
  end
  save_excel(ws)
end

# Scrap the infos
def scrap(url, browser, _game, _style)
  data = {
    'tr_index_country' => [],
    'tr_index_inter' => [],
    'tr_name' => [],
    'tr_team' => [],
    'tr_character' => [],
    'tr_actual_score' => [],
    'tr_tournament' => [],
    'tr_country' => []
  }

  worksheet = {
    'titles' => ['Rank country', 'Rank international', 'Name', 'Team', 'Character', 'Actual score', 'Number of tournament', 'Country'],
    'ws_num' => 1,
    'ws_url' => '161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY'
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
          data['tr_index_country'] << col.text
        when 1
          data['tr_index_inter'] << col.text
        when 2
          data['tr_name'] << col.text
        when 3
          data['tr_team'] << col.text
        when 4
          data['tr_character'] << col.text
        when 5
          data['tr_actual_score'] << col.text
        when 6
          data['tr_tournament'] << col.text
        when 7
          data['tr_country'] << col.text
        else
          next
        end
      end
    end
  end
  data_to_excel(data, worksheet)
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
