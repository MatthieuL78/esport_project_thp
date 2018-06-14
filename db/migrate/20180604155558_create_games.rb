class CreateGames < ActiveRecord::Migration[5.2]
  def change
    change_table :games do |t|
      t.string :name
      t.string :type
      t.string :picture
    end
  end
end
