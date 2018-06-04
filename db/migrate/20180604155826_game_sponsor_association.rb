class GameSponsorAssociation < ActiveRecord::Migration[5.2]
  def change
  	create_table :gamesponsorassociations do |t|
      t.belongs_to :game, index: true
      t.belongs_to :sponsor, index: true
      t.timestamps
  	end
  end
end
