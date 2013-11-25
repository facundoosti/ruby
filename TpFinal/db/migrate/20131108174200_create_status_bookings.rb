class CreateStatusBookings < ActiveRecord::Migration
  def change
    create_table :status_bookings do |t|
     
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
