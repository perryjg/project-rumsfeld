# == Schema Information
#
# Table name: statuses
#
#  id         :integer         not null, primary key
#  status     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  request_id :integer
#

class Status < ActiveRecord::Base
  attr_accessible :status
  belongs_to :request

  validates :request_id, presence: true
  default_scope order: 'statuses.created_at DESC'
end
