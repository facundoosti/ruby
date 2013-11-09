class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.datetime   :occupancy_date 
      t.datetime   :disoccupation_date
      t.references :state_request
      t.references :resource
 
      t.timestamps
    end
  end
end


