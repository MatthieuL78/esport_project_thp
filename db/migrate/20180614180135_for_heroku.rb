class ForHeroku < ActiveRecord::Migration[5.2]
  def change
  	if column_exists?(:events, :created_at)
  	  remove_column(:events, :created_at)
  	end
    if column_exists?(:events, :updated_at)
      remove_column(:events, :updated_at)
    end
  end
end
