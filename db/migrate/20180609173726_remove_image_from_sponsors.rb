class RemoveImageFromSponsors < ActiveRecord::Migration[5.2]
  def change
    remove_column :sponsors, :profile_image_id, :string
    remove_column :sponsors, :profile_image_filename, :string
    remove_column :sponsors, :profile_image_content_size, :string
    remove_column :sponsors, :profile_image_content_type, :string
  end
end
