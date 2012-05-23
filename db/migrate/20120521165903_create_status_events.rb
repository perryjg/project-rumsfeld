class CreateStatusEvents < ActiveRecord::Migration
  def change
    create_table :status_events do |t|
      t.string :status_name

      t.timestamps
    end

  	["pending","sent","response received","denied","partially denied","appealed","approved","partial_documents_received","documents_received"].each do |status|
  		StatusEvent.create status_name: status
    end
	end
end
