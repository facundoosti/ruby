class CreateStateRequests < ActiveRecord::Migration
  def change
    create_table :state_requests do |t|
     
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
