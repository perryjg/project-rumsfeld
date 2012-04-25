class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :sender
      t.string :sender_title
      t.string :sender_organization
      t.string :sender_email
      t.string :recipient
      t.string :email
      t.string :title
      t.string :organization
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.text :final_text
      t.references :user
      t.references :request_type

      t.timestamps
    end
    add_index :letters, :user_id
    add_index :letters, :request_type_id
  end
end
