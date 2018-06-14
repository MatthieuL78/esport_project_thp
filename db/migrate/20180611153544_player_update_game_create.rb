class PlayerUpdateGameCreate < ActiveRecord::Migration[5.2]
  def change
    change_table :players do |t|
      t.string :index_country
      t.string :index_inter
      t.string :team
      t.string :character
      t.string :actual_score
      t.string :tournament
      t.string :country
    end
    
    change_table :games do |t|
      t.string :avg_view_rk
      t.string :pk_view_rk
      t.string :avg_chan_rk
      t.string :pk_chan_rk
      t.string :watch_time
      t.string :max_view
      t.string :avg_view
      t.string :ratio
    end
  end
end
