class CreateStatusEvents < ActiveRecord::Migration
  def change
    create_table :status_events do |t|
      t.string :status_name

      t.timestamps
    end
  end
end
