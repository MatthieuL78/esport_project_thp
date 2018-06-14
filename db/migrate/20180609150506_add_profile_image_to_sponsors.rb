class AddProfileImageToSponsors < ActiveRecord::Migration[5.2]
  def change
    add_column :sponsors, :profile_image_id, :string
    add_column :sponsors, :profile_image_filename, :string
    add_column :sponsors, :profile_image_content_size, :string
    add_column :sponsors, :profile_image_content_type, :string
  end
end
