class CreateStateBookings < ActiveRecord::Migration
  def change
    create_table :state_bookings do |t|
     
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
