class ReorganizeGamesTable < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.change :picture, :string, after: :ratio
      t.change :updated_at, :datetime, after: :ratio
      t.change :created_at, :datetime, after: :ratio
    end
  end
end
