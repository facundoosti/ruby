class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      
      t.datetime   :start 
      t.datetime   :end
      
      t.references :status 
      t.references :resource
 
      t.timestamps
    end
  end
end


