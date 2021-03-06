# frozen_string_literal: true

require 'watir'
require 'google_drive'

# Create my url
def my_url_player(country, game)
  'http://rank.shoryuken.com/rankings/rank?country=' + country + '&pchar=any+character&rankingType=ACTUAL&_filtermain=&id=' + game
end

# Scrap the infos
def scrap_player(url, browser, _game, _style, row_max)
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
  data_to_excel(data, worksheet, row_max)
end

# Scraping data on smash GG for : Tournament
# Datas : Tournament : Name - Date - Image - place - nb of attendees
# Data fill manually : Style - Game
# Choose your game : Tekken 7, Street fighter

# Make a table with all the game's name to scrap

def main_player
  # Add the following information :
  my_game = 'SF5'
  style = 'combat'
  my_country = 'france'
  # End
  row_max = 2
  # Add a while for many pages ...
  url = my_url_player(my_country, my_game)
  browser = Watir::Browser.new :chrome, scrapping_options
  scrap_player(url, browser, my_game, style, row_max)
  row_max += 100
end
