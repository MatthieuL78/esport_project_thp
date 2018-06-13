class UpdateGamesColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :picture
    remove_column :games, :created_at
    remove_column :games, :updated_at
  end
end
