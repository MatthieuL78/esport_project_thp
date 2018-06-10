def init_session(worksheet)
  session = GoogleDrive::Session.from_config('config.json')
  ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[worksheet]
end

def save_excel(spreadsheet)
  spreadsheet.save
  spreadsheet.reload
end