class UpdateEventScrap < ActiveRecord::Migration[5.2]
  def change
  	remove_column :events, :name
  	remove_column :events, :place
  	remove_column :events, :attendee
  	remove_column :events, :game
  	remove_column :events, :style
  	remove_column :events, :image
  	remove_column :events, :date
  	change_table :events do |t|
      t.string :name
      t.string :picture
      t.string :date
      t.string :attendee
      t.string :place
      t.string :style
      t.string :game
  	end
  end
end
