namespace :db do
	desc "Load preliminary data"
	task populate: :environment do
	  StatusEvent.delete_all
	  
		["pending","sent","response received","denied","partially denied","approved","documents_received"].each do |status|
			StatusEvent.create!( status_name: status )
		end
	end
end