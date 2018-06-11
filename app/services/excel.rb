# frozen_string_literal: true

# Initialization Spreadsheet
def init_spreadsheet(worksheet_hash)
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key(worksheet_hash['ws_url']).worksheets[worksheet_hash['ws_num']]
  worksheet_hash['titles'].each_with_index { |title_value, index| ws[1, index + 1] = title_value }
  ws
end

# Save the spreadsheet
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
