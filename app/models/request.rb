class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :request_type
  attr_accessible :recipient_addr, :recipient_city, :recipient_name,
                  :recipient_organization, :recipient_state,
                  :recipient_title, :request_type_id, :recipient_zip,
                  :request_text, :user_id

  validates :user_id, presence: true
  validates :recipient_name, presence: true
  validates :recipient_addr, presence: true
  validates :recipient_city, presence: true
  validates :recipient_state, presence: true, length: { maximum: 2, minimum: 2 }
  validates :recipient_zip, presence: true
end
