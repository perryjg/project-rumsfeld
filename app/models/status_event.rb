# == Schema Information
#
# Table name: status_events
#
#  id          :integer         not null, primary key
#  status_name :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class StatusEvent < ActiveRecord::Base
  attr_accessible :status_name
  has_many :statuses
  validates :status_name, presence: true, uniqueness: true
end
