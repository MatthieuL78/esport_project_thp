class EventPlayerAssociation < ActiveRecord::Migration[5.2]
  def change
  	create_table :events_players do |t|
      t.belongs_to :player, index: true
      t.belongs_to :event, index: true
      t.timestamps
  	end
  end
end
