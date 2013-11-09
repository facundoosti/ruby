class CreateStateRequests < ActiveRecord::Migration
  def change
    create_table :state_request do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
