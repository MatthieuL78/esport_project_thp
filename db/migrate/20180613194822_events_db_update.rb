class EventsDbUpdate < ActiveRecord::Migration[5.2]
  def up
  	change_table :events do |t|
  	  t.remove :name, :place, :attendee, :game, :style, :image, :date
  	  t.string :name, :image, :date, :attendee, :place, :style
    end
  end
end
