class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
     
      t.string :e_mail

      t.timestamps
    end
  end
end
