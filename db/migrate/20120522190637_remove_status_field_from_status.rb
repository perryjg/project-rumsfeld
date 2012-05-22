class RemoveStatusFieldFromStatus < ActiveRecord::Migration
  def up
  	remove_column :statuses, :status
  end

  def down
  	add_column :statuses, :status, :string
  end
end
