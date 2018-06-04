class GamePlayerAssociation < ActiveRecord::Migration[5.2]
  def change
  	create_table :games_players do |t|
      t.belongs_to :player, index: true
      t.belongs_to :game, index: true
      t.timestamps
  	end
  end
end
