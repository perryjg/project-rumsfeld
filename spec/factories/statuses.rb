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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status do
    status_event_id 1
    request
  end
end
