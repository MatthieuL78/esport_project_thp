class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :place
      t.date :date_begin
      t.date :date_end
      t.timestamps
    end
  end
end
