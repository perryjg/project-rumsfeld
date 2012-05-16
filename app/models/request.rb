# == Schema Information
#
# Table name: requests
#
#  id                     :integer         not null, primary key
#  recipient_name         :string(255)
#  recipient_title        :string(255)
#  recipient_organization :string(255)
#  recipient_addr         :string(255)
#  recipient_city         :string(255)
#  recipient_state        :string(255)
#  recipient_zip          :string(255)
#  request_text           :text
#  user_id                :integer
#  request_type_id        :integer
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :request_type
  attr_accessible :recipient_addr, :recipient_city, :recipient_name,
                  :recipient_organization, :recipient_state,
                  :recipient_title, :request_type_id, :recipient_zip,
                  :request_text
                  
  liquid_methods :recipient_name, :recipient_title, :recipient_organization,
                 :request_text, :created_at, :user_name
  
  validates :user_id,         presence: true
  validates :recipient_name,  presence: true
  validates :recipient_addr,  presence: true
  validates :recipient_city,  presence: true
  validates :recipient_state, presence: true, length: { maximum: 2, minimum: 2 }
  validates :recipient_zip,   presence: true
  validates :request_type_id, presence: true
  default_scope order: 'requests.created_at DESC'

  delegate :template, to: :request_type
  delegate :name, :email, :phone, :title, :organization,
           :address, :city, :state, :zip,
           to: :user, prefix: true
end
