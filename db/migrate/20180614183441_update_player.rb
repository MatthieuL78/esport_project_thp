class UpdatePlayer < ActiveRecord::Migration[5.2]
  def change
  	if column_exists?(:players, :nickname)
  	  remove_column(:players, :nickname)
  	end
  	remove_column :players, :index_country
  	remove_column :players, :index_inter
  	remove_column :players, :team
  	remove_column :players, :character
  	remove_column :players, :actual_score
  	remove_column :players, :tournament
  	remove_column :players, :country
  	
  	change_table :players do |t|
      t.string :index_country
      t.string :index_inter
      t.string :nickname
      t.string :team
      t.string :character
      t.string :actual_score
      t.string :nb_tournmanet
      t.string :country
  	end
  end
end
