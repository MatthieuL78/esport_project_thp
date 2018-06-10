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
def save_data_on_spreadsheet(player_hash)
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[1]
  ws[1, 1] = 'Rank country'
  ws[1, 2] = 'Rank international'
  ws[1, 3] = 'Name'
  ws[1, 4] = 'Team'
  ws[1, 5] = 'Character'
  ws[1, 6] = 'Actual score'
  ws[1, 7] = 'Number of tournament'
  ws[1, 8] = 'Country'

  (2..player_hash['tr_index_country'].length).each_with_index do |row, index|
    ws[row, 1] = player_hash['tr_index_country'][index]
    ws[row, 2] = player_hash['tr_index_inter'][index]
    ws[row, 3] = player_hash['tr_name'][index]
    ws[row, 4] = player_hash['tr_team'][index]
    ws[row, 5] = player_hash['tr_character'][index]
    ws[row, 6] = player_hash['tr_actual_score'][index]
    ws[row, 7] = player_hash['tr_tournament'][index]
    ws[row, 8] = player_hash['tr_country'][index]
  end
  ws.save
  ws.reload
end

# Scrap the infos
def scrap(url, browser, game, style)
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
  content_to_scrapp = ''

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
  save_data_on_spreadsheet(player)
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
