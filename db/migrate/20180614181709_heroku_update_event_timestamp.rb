class HerokuUpdateEventTimestamp < ActiveRecord::Migration[5.2]
  def change
  	change_table :events do |t|
  	  t.timestamp
  	end
  end
end
