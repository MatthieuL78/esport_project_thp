class PlayerSponsorAssociation < ActiveRecord::Migration[5.2]
  def change
  	create_table :players_sponsors do |t|
      t.belongs_to :player, index: true
      t.belongs_to :sponsor, index: true
      t.timestamps
  	end
  end
end
