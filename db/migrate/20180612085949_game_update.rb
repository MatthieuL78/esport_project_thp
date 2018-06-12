class GameUpdate < ActiveRecord::Migration[5.2]
  def change
  	rename_column(:games, :type, :style)
  end
end
