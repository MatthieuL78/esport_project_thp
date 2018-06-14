class DvpDbUpdate < ActiveRecord::Migration[5.2]
  def change
	remove_column :players, :country
	remove_column :players, :created_at
	remove_column :players, :updated_at

	change_table :players do |t|
      t.string :nb_tournament
      t.string :country
      t.timestamps default: Time.now   
	end
  	
  end
end
