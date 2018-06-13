class ReorganizeGamesTableBis < ActiveRecord::Migration[5.2]
  def up
    change_column :games, :picture, :string, after: :ratio
    change_column :games, :updated_at, :datetime, after: :ratio
    change_column :games, :created_at, :datetime, after: :ratio
  end
end
