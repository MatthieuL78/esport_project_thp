class EventSponsorAssociation < ActiveRecord::Migration[5.2]
  def change
  	create_table :eventsponsorassociations do |t|
      t.belongs_to :event, index: true
      t.belongs_to :sponsor, index: true
      t.timestamps
  	end
  end
end
