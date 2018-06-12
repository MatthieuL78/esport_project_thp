class AddAvatarToSponsors < ActiveRecord::Migration[5.2]
  def change
    add_column :sponsors, :avatar, :string
  end
end
