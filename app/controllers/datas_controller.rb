# frozen_string_literal: true

require 'google_drive'

# Controller for admin website data
class DatasController < ApplicationController
  protect_from_forgery with: :exception
  def show_data; end

  def save_data_event(worksheet)
    ws = init_session(worksheet)
    2.upto(ws.num_rows) do |row|
      if Event.where(name: ws[row, 1]).exists?
        event = Event.find_by_name(ws[row, 1])
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
          if Game.where(name: ws[row, col]).exists?
            if event.games.find_by(name: ws[row, col]).nil?
              event.games << Game.find_by_name(ws[row, col])
            end
          else
            event.game = ws[row, col]
          end
        else
          event.style = ws[row, col]
        end
      end
      event.save
    end
    redirect_to events_path
  end

  def save_data_player(worksheet)
    # We have to create another model for the real version
    i = 10
    ws = init_session(worksheet)
    2.upto(ws.num_rows) do |row|
      if Player.where(nickname: ws[row, 3]).exists?
        player = Player.find_by_nickname(ws[row, 3])
      else
        player = Player.create!(email: 'jack@jack' + i.to_s + '.com', password: Devise.friendly_token.first(8))
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

  def save_data_game(worksheet)
    ws = init_session(worksheet)
    2.upto(ws.num_rows) do |row|
      ws[row, 1] = replace_underscore_by_space(ws[row, 1])
      if Game.where(name: ws[row, 1]).exists?
        game = Game.find_by_name(ws[row, 1])
      else
        game = Game.new
      end
      0.upto(ws.num_cols) do |col|
        game.column_name[col + 1] = ws[row, col]

        # case col
        # when 1
        #   game.name = ws[row, col]
        # when 2
        #   game.style = ws[row, col]
        # when 3
        #   game.avg_view_rk = ws[row, col]
        # when 4
        #   game.pk_view_rk = ws[row, col]
        # when 5
        #   game.avg_chan_rk = ws[row, col]
        # when 6
        #   game.pk_chan_rk = ws[row, col]
        # when 7
        #   game.watch_time = ws[row, col]
        # when 8
        #   game.max_view = ws[row, col]
        # when 9
        #   game.avg_view = ws[row, col]
        # else
        #   game.ratio = ws[row, col]
        # end
      end
      game.save
    end
    # redirect_to games_path
  end

  # Function for scrapping
  def scrapp_datas
    case params[:scrapp_id]
    when '1'
      main_event
    when '2'
      main_player
    when '3'
      main_game
    else
      # flash alert bug
      return
    end
    # add a flash alert
    redirect_to show_data_event_path
  end

  def save_ws_on_db
    worksheet = {
      'ws_num' => 0,
      'ws_url' => '161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY'
    }
    case params[:save_id]
    when '1'
      save_data_event(worksheet)
    when '2'
      worksheet[:ws_num] = 1
      save_data_player(worksheet)
    when '3'
      worksheet[:ws_num] = 2
      save_data_game(worksheet)
    else
      # flash alert bug
      return
    end
    # add a flash alert
    redirect_to show_data_event_path
  end
end
