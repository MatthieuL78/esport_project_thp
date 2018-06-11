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
def my_url(game)
  'https://sullygnome.com/game/' + game + '/30/summary'
end

def init_spreadsheet
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[2]
  title = ['Average viewers rank', 'Peak viewers rank', 'Average channels rank', 'Peak channels rank', 'Watch time', 'Max viewers', 'Average viewers', 'Ratio']
  title.each_with_index { |title_value, index| ws[1, index + 1] = title_value }
  ws
end

def save_excel(spreadsheet)
  spreadsheet.save
  spreadsheet.reload
end

# Create a Spreadsheet on google drive
def data_to_excel(game_hash)
  ws = init_spreadsheet
  (2..game_hash['tr_avg_view_rk'].length + 2).each_with_index do |row, index|
    8.times do |i|
      ws[row, i + 1] = game_hash[game_hash.keys[i]][index]
    end
  end
  save_excel(ws)
end

# Scrap the infos
def scrap(url, browser, _style)
  game = {
    'tr_avg_view_rk' => [],
    'tr_pk_view_rk' => [],
    'tr_avg_chan_rk' => [],
    'tr_pk_chan_rk' => [],
    'tr_watch_time' => [],
    'tr_max_view' => [],
    'tr_avg_view' => [],
    'tr_ratio' => []
  }

  browser.goto url

  # Get the datas
  # I don't create a function if the call is one line
  content_to_scrapp = browser.divs(class: 'MiddleSubHeaderItemValue')
  content_to_scrapp.each_with_index do |col, index|
    case index
    when 0
      game['tr_avg_view_rk'] << col.text
    when 1
      game['tr_pk_view_rk'] << col.text
    when 2
      game['tr_avg_chan_rk'] << col.text
    when 3
      game['tr_pk_chan_rk'] << col.text
    else
      next
    end
  end

  content_to_scrapp = browser.divs(class: %w[InfoPanelRowRight BoldText])
  content_to_scrapp.each_with_index do |col, index|
    case index
    when 0
      game['tr_watch_time'] << col.text
    when 1
      game['tr_max_view'] << col.text
    when 2
      game['tr_avg_view'] << col.text
    when 3
      game['tr_ratio'] << col.text
    else
      next
    end
  end

  data_to_excel(game)
end

# Scraping data on smash GG for : Tournament
# Datas : Tournament : Name - Date - Image - place - nb of attendees
# Data fill manually : Style - Game
# Choose your game : Tekken 7, Street fighter

# Make a table with all the game's name to scrap

def main
  # Add the following information :
  my_game = 'Tekken_7'
  style = 'combat'
  # End

  url = my_url(my_game)
  browser = Watir::Browser.new :firefox
  scrap(url, browser, style)
end

main
