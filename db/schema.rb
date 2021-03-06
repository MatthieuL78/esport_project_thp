# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_14_192206) do

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.string "date"
    t.string "attendee"
    t.string "place"
    t.string "style"
    t.string "game"
    t.datetime "created_at", default: "2018-06-14 18:20:35", null: false
    t.datetime "updated_at", default: "2018-06-14 18:20:35", null: false
  end

  create_table "events_games", force: :cascade do |t|
    t.integer "game_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_events_games_on_event_id"
    t.index ["game_id"], name: "index_events_games_on_game_id"
  end

  create_table "events_players", force: :cascade do |t|
    t.integer "player_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_events_players_on_event_id"
    t.index ["player_id"], name: "index_events_players_on_player_id"
  end

  create_table "events_sponsors", force: :cascade do |t|
    t.integer "event_id"
    t.integer "sponsor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_events_sponsors_on_event_id"
    t.index ["sponsor_id"], name: "index_events_sponsors_on_sponsor_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "style"
    t.string "view_rk_avg"
    t.string "view_rk_max"
    t.string "chan_rk_avg"
    t.string "chan_rk_max"
    t.string "watch_time"
    t.string "viewer_max"
    t.string "viewer_avg"
    t.string "ratio"
  end

  create_table "games_players", force: :cascade do |t|
    t.integer "player_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_games_players_on_game_id"
    t.index ["player_id"], name: "index_games_players_on_player_id"
  end

  create_table "games_sponsors", force: :cascade do |t|
    t.integer "game_id"
    t.integer "sponsor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_games_sponsors_on_game_id"
    t.index ["sponsor_id"], name: "index_games_sponsors_on_sponsor_id"
  end

  create_table "players", id: false, force: :cascade do |t|
    t.integer "test"
    t.string "email"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "last_name"
    t.string "first_name"
    t.string "picture"
    t.text "description"
    t.date "date_of_birth"
    t.integer "phone"
    t.boolean "status"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "index_country"
    t.string "index_inter"
    t.string "nickname"
    t.string "team"
    t.string "character"
    t.string "actual_score"
    t.string "nb_tournament"
    t.string "country"
    t.datetime "created_at", default: "2018-06-14 19:24:53", null: false
    t.datetime "updated_at", default: "2018-06-14 19:24:53", null: false
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  create_table "players_sponsors", force: :cascade do |t|
    t.integer "player_id"
    t.integer "sponsor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_players_sponsors_on_player_id"
    t.index ["sponsor_id"], name: "index_players_sponsors_on_sponsor_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "name"
    t.string "website"
    t.string "picture"
    t.integer "phone"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "description"
    t.string "avatar"
    t.index ["email"], name: "index_sponsors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sponsors_on_reset_password_token", unique: true
  end

end
