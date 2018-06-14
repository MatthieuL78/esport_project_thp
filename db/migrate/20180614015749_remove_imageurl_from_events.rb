class RemoveImageurlFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :imageurl, :string
  end
end
