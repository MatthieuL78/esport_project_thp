class EventGameAssociation < ActiveRecord::Migration[5.2]
  def change
  	create_table :events_games do |t|
      t.belongs_to :game, index: true
      t.belongs_to :event, index: true
      t.timestamps
  	end
  end
end
