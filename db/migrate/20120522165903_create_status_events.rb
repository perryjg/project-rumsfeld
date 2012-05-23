class CreateStatusEvents < ActiveRecord::Migration
  def up
    create_table :status_events do |t|
      t.string :status_name

      t.timestamps
    end
  end

	["pending","sent","response received","denied","partially denied","approved","documents_received"].each do |status|
		StatusEvent.create status_name: status
	end

  def down
  	drop_table :status_events
  end
end
