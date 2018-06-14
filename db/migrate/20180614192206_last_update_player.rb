class LastUpdatePlayer < ActiveRecord::Migration[5.2]
  def change
  	remove_column :players, :index_country
	remove_column :players, :index_inter
	remove_column :players, :nickname
	remove_column :players, :team
	remove_column :players, :character
	remove_column :players, :actual_score
	remove_column :players, :nb_tournament
	remove_column :players, :country
	remove_column :players, :created_at
	remove_column :players, :updated_at
	change_table :players do |t|
      t.string :index_country
      t.string :index_inter
      t.string :nickname
      t.string :team
      t.string :character
      t.string :actual_score
      t.string :nb_tournament
      t.string :country
      t.timestamps default: Time.now
	end
  end
end
