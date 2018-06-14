class GamesUpdateScrapp < ActiveRecord::Migration[5.2]
  def change
  	remove_column :games, :name
    remove_column :games, :style
    remove_column :games, :picture
    remove_column :games, :avg_view_rk
  	remove_column :games, :pk_view_rk
  	remove_column :games, :avg_chan_rk
  	remove_column :games, :pk_chan_rk
  	remove_column :games, :watch_time
  	remove_column :games, :max_view
  	remove_column :games, :avg_view
  	remove_column :games, :ratio
  	
  	change_table :games do |t|
  	  t.string :name
  	  t.string :style
  	  t.string :view_rk_avg
  	  t.string :view_rk_max
  	  t.string :chan_rk_avg
  	  t.string :chan_rk_max
  	  t.string :watch_time
  	  t.string :viewer_max
  	  t.string :viewer_avg
  	  t.string :ratio
    end
  end
end
