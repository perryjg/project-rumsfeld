# == Schema Information
#
# Table name: statuses
#
#  id              :integer         not null, primary key
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  request_id      :integer
#  status_event_id :integer
#

class Status < ActiveRecord::Base
  attr_accessible :status_event_id
  belongs_to :request
  belongs_to :status_event

  validates :request_id, presence: true
  default_scope order: 'statuses.created_at DESC'

  def status
  	status_event.status_name
  end
end
