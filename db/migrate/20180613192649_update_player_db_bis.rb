class UpdatePlayerDbBis < ActiveRecord::Migration[5.2]
  def up
  	change_table :players do |t|
  	  t.remove :players, :nickname, :team, :character, :actual_score, :tournament, :country
  	  t.string :nickname, :team, :character, :actual_score, :tournament, :country
    end
  end
end
