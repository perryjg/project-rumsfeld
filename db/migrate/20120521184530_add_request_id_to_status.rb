class AddRequestIdToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :request_id, :integer
  end
end
