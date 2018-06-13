class UpdatePlayerDb < ActiveRecord::Migration[5.2]
  def change
  change_column :players, :nickname, :string, after: :index_inter
  end
end
