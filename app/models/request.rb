class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :request_type
  attr_accessible :recipient_addr, :recipient_city, :recipient_name,
                  :recipient_organization, :recipient_state,
                  :recipient_title, :recipient_type_id, :recipient_zip,
                  :request_text, :user_id
end
