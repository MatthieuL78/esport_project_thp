class EventUpdate < ActiveRecord::Migration[5.2]
  def change
  	change_table :events do |t|
      t.integer :attendee
      t.string :game
      t.string :style
      t.string :image
  	  t.string :date
  	end
  	remove_column :events, :date_begin
  	remove_column :events, :date_end
  end
end
