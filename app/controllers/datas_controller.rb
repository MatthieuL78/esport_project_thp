# frozen_string_literal: true

require 'google_drive'

class DatasController < ApplicationController

  def show_data; end

  def save_data_from_spreadsheet_event
    session = GoogleDrive::Session.from_config('config.json')
    ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[0]
    2.upto(10) do |row|
      # 
      # Need to check on the database if the event already exist
      #
      event = Event.new
      1.upto(7) do |col|
        case col
        when 1
          event.name = ws[row, col]
        when 2
          event.image = ws[row, col]
        when 3
          event.date = ws[row, col]
        when 4
          event.attendee = ws[row, col]
        when 5
          event.place = ws[row, col]
        when 6
          event.game = ws[row, col]
        else
          event.style = ws[row, col]
        end
      end
      event.save
    end
    redirect_to events_path
  end

  def save_data_from_spreadsheet_player
    session = GoogleDrive::Session.from_config('config.json')
    ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[1]
    2.upto(10) do |row|
      # 
      # Need to check on the database if the event already exist
      #
      event = Event.new
      1.upto(7) do |col|
        case col
        when 1
          event.name = ws[row, col]
        when 2
          event.image = ws[row, col]
        when 3
          event.date = ws[row, col]
        when 4
          event.attendee = ws[row, col]
        when 5
          event.place = ws[row, col]
        when 6
          event.game = ws[row, col]
        else
          event.style = ws[row, col]
        end
      end
      event.save
    end
    redirect_to events_path
  end

  def save_data_from_spreadsheet_game
    session = GoogleDrive::Session.from_config('config.json')
    ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[2]
    2.upto(10) do |row|
      # 
      # Need to check on the database if the event already exist
      #
      event = Event.new
      1.upto(7) do |col|
        case col
        when 1
          event.name = ws[row, col]
        when 2
          event.image = ws[row, col]
        when 3
          event.date = ws[row, col]
        when 4
          event.attendee = ws[row, col]
        when 5
          event.place = ws[row, col]
        when 6
          event.game = ws[row, col]
        else
          event.style = ws[row, col]
        end
      end
      event.save
    end
    redirect_to events_path
  end

  def scrapp_events
    main_event
    redirect_to show_data_event_path
  end

  def scrapp_players
    main_player
    redirect_to show_data_event_path
  end

  def scrapp_games
  	main_game
  	redirect_to show_data_event_path
  end

end