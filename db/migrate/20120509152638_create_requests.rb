class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :recipient_name
      t.string :recipient_title
      t.string :recipient_organization
      t.string :recipient_addr
      t.string :recipient_city
      t.string :recipient_state, length: 2
      t.string :recipient_zip
      t.text :request_text
      t.integer :user_id
      t.integer :request_type_id

      t.timestamps
    end
  end
end
