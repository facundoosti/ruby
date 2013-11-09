class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
 			t.references :state_resource
      t.timestamps
    end
  end
end
