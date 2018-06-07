# frozen_string_literal: true

require 'google_drive'

def get_data_from_spreadsheet

session = GoogleDrive::Session.from_config('config.json')
ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[0]

p ws.num_rows
p ws.num_cols

end

get_data_from_spreadsheet