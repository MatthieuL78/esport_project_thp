class PlayerBigUpdate < ActiveRecord::Migration[5.2]
  def change
  	if column_exists?(:players, :tournament)
  	  remove_column(:players, :tournament)
  	end
  	if column_exists?(:players, :nb_tournmanet)
  	  remove_column(:players, :nb_tournmanet)
  	end
  	if column_exists?(:players, :created_at)
  	  remove_column(:players, :created_at)
  	end
  	if column_exists?(:players, :updated_at)
  	  remove_column(:players, :updated_at)
  	end
    
    if column_exists?(:players, :index_country)
  	  remove_column :players, :index_country
  	  remove_column :players, :index_inter
  	  remove_column :players, :nickname
  	  remove_column :players, :team
  	  remove_column :players, :character
  	  remove_column :players, :actual_score
  	  remove_column :players, :country
  	end

  	change_table :players do |t|
      t.string :index_country
      t.string :index_inter
      t.string :nickname
      t.string :team
      t.string :character
      t.string :actual_score
      t.string :country
      t.timestamps default: Time.now
  	end
  end
end
