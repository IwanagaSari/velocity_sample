# encoding: utf-8

require 'google_drive'

session = GoogleDrive.login_with_oauth('')
ws = session.spreadsheet_by_key('').worksheets[0]
p ws[1, 1]

ws[1, 2] = 'いまでしょ'
ws.save
