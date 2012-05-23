class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :title
      t.string :organization
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :password_digest
      
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
