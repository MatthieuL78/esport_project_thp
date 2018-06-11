def init_spreadsheet(titles, ws_url, ws_num)
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key(ws_url).worksheets[ws_num]
  titles.each_with_index { |title_value, index| ws[1, index + 1] = title_value }
  ws
end

def save_excel(spreadsheet)
  spreadsheet.save
  spreadsheet.reload
end