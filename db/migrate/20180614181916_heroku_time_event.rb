class HerokuTimeEvent < ActiveRecord::Migration[5.2]
  def change
  	change_table :events do |t|
  	  t.timestamps default: Time.now
  	end
  end
end
