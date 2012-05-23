class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :request_id
      t.integer :status_event_id

      t.timestamps
    end
  end
end
