# frozen_string_literal: true

require 'google_drive'

# Controller for admin website data
class DatasController < ApplicationController
  protect_from_forgery with: :exception
  def show_data; end

  def save_data_event(worksheet)
    ws = init_session(worksheet)
    2.upto(ws.num_rows - 1) do |row|
      # DRY have the same column for name on spreadsheet
      if Event.where(name: ws[row, 1]).exists?
        event = Event.find_by_name(ws[row, 1])
      else
        event = Event.new
      end
      1.upto(ws.num_cols) do |col|
        col_name_sym = Event.column_names[col + 2].to_sym
        event.attributes = { col_name_sym => ws[row, col] }
      end
      if Game.where(name: ws[row, 7]).exists?
        if event.games.find_by(name: ws[row, 7]).nil?
          event.games << Game.find_by_name(ws[row, 7])
        end
      end
      event.save
    end
  end

  def save_data_player(worksheet)
    # We have to create another model for the real version
    i = 10
    ws = init_session(worksheet)
    2.upto(ws.num_rows) do |row|
      # DRY have the same column for name on spreadsheet
      if Player.where(nickname: ws[row, 3]).exists?
        player = Player.find_by_nickname(ws[row, 3])
      else
        # To delete for the real version of the app
        # Because we will use an other table for the scrapping
        player = Player.new(email: 'jack@jack' + i.to_s + '.com', password: Devise.friendly_token.first(8))
      end

      1.upto(ws.num_cols) do |col|
        col_name_sym = Player.column_names[col + 16].to_sym
        player.attributes = { col_name_sym => ws[row, col] }
      end
      player.save
      i += 1
    end
  end

  def save_data_game(worksheet)
    ws = init_session(worksheet)
    2.upto(ws.num_rows) do |row|
      ws[row, 1] = replace_underscore_by_space(ws[row, 1])
      # DRY have the same column for name on spreadsheet
      if Game.where(name: ws[row, 1]).exists?
        game = Game.find_by_name(ws[row, 1])
      else
        game = Game.new
      end
      1.upto(ws.num_cols) do |col|
        col_name_sym = Game.column_names[col + 2].to_sym
        game.attributes = { col_name_sym => ws[row, col] }
      end
      game.save
    end
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

  # Function for save ws on db
  def save_ws_on_db
    worksheet = {
      'ws_num' => 0,
      'ws_url' => '161w9F2_0vwwRpfr4ggATvXL0J_xUW83-Q7Y5IffgyWY'
    }
    case params[:save_id]
    # The ideal is to have 1 function save_data DRY
    when '1'
      save_data_event(worksheet)
    when '2'
      worksheet['ws_num'] = 1
      save_data_player(worksheet)
    when '3'
      worksheet['ws_num'] = 2
      save_data_game(worksheet)
    else
      # flash alert bug
      return
    end
    # add a flash alert
    redirect_to show_data_event_path
  end
end
