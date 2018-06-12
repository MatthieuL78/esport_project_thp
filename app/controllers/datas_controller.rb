# frozen_string_literal: true

require 'google_drive'

class DatasController < ApplicationController

  def show_data; end

  def save_data_from_spreadsheet_event
    session = GoogleDrive::Session.from_config('config.json')
    ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[0]
    2.upto(ws.num_rows) do |row|
      # 
      # Need to check on the database if the event already exist
      #
      if Event.where(name: ws[row, 1]).exists?
        event = Event.find_by(name: ws[row, 1])
      else  
        event = Event.new
      end
      1.upto(ws.num_cols) do |col|
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
    i = 10
    session = GoogleDrive::Session.from_config('config.json')
    ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[1]
    2.upto(ws.num_rows) do |row|
      # 
      # Need to check on the database if the event already exist
      #
      if Player.where(nickname: ws[row, 3]).exists?
        player = Player.find_by_nickname(ws[row, 3])
      else
        player = Player.create!(email: "jack@jack" + i.to_s + ".com", password: Devise.friendly_token.first(8))
      end
      1.upto(ws.num_cols) do |col|
        case col
        when 1
          player.index_country = ws[row, col]
        when 2
          player.index_inter = ws[row, col]
        when 3
          player.nickname = ws[row, col]
        when 4
          # We have to change when we will create team
          player.team = ws[row, col]
        when 5
          player.character = ws[row, col]
        when 6
          player.actual_score = ws[row, col]
        when 7
          player.tournament = ws[row, col]
        else
          player.country = ws[row, col]
        end
      end
      player.save
      i += 1
    end
    # redirect_to players_path
  end

  def save_data_from_spreadsheet_game
    session = GoogleDrive::Session.from_config('config.json')
    ws = session.spreadsheet_by_key('161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY').worksheets[2]
    2.upto(ws.num_rows) do |row|
      # 
      # Need to check on the database if the event already exist
      #
      game = Game.new
      1.upto(ws.num_cols) do |col|
        case col
        when 1
          game.avg_view_rk = ws[row, col]
        when 2
          game.pk_view_rk = ws[row, col]
        when 3
          game.avg_chan_rk = ws[row, col]
        when 4
          game.pk_chan_rk = ws[row, col]
        when 5
          game.watch_time = ws[row, col]
        when 6
          game.max_view = ws[row, col]
        when 7
          game.avg_view = ws[row, col]  
        else
          game.ratio = ws[row, col]
        end
      end
      game.name = 'Tekken 7'
      game.type = 'Combat'
      game.save
    end
    # redirect_to games_path
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

  private

end