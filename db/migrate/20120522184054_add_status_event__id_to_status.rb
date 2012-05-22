class AddStatusEventIdToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :status_event_id, :integer
  end
end
