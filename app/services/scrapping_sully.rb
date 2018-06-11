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
def data_to_excel(data_hash, worksheet_hash, row_max)
  ws = init_spreadsheet(worksheet_hash)
  (row_max..data_hash[data_hash.keys[0]].length + row_max).each_with_index do |col, index|
    worksheet_hash['titles'].length.times do |i|
      ws[col, i + 1] = data_hash[data_hash.keys[i]][index]
    end
  end
  save_excel(ws)
end

# Scrap the infos
def scrap(url, browser, _style, row_max)
  data = {
    'tr_avg_view_rk' => [],
    'tr_pk_view_rk' => [],
    'tr_avg_chan_rk' => [],
    'tr_pk_chan_rk' => [],
    'tr_watch_time' => [],
    'tr_max_view' => [],
    'tr_avg_view' => [],
    'tr_ratio' => []
  }

  worksheet = {
    'titles' => ['Average viewers rank', 'Peak viewers rank', 'Average channels rank', 'Peak channels rank', 'Watch time', 'Max viewers', 'Average viewers', 'Ratio'],
    'ws_num' => 2,
    'ws_url' => '161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY'
  }
  

  browser.goto url

  # Get the datas
  # I don't create a function if the call is one line
  content_to_scrapp = browser.divs(class: 'MiddleSubHeaderItemValue')
  content_to_scrapp.each_with_index do |col, index|
    case index
    when 0
      data['tr_avg_view_rk'] << col.text
    when 1
      data['tr_pk_view_rk'] << col.text
    when 2
      data['tr_avg_chan_rk'] << col.text
    when 3
      data['tr_pk_chan_rk'] << col.text
    else
      next
    end
  end

  content_to_scrapp = browser.divs(class: %w[InfoPanelRowRight BoldText])
  content_to_scrapp.each_with_index do |col, index|
    case index
    when 0
      data['tr_watch_time'] << col.text
    when 1
      data['tr_max_view'] << col.text
    when 2
      data['tr_avg_view'] << col.text
    when 3
      data['tr_ratio'] << col.text
    else
      next
    end
  end

  data_to_excel(data, worksheet, row_max)
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
  row_max = 2

  url = my_url(my_game)
  browser = Watir::Browser.new :firefox
  scrap(url, browser, style, row_max)
  row_max += 100
end
