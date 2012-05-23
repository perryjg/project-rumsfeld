# == Schema Information
#
# Table name: status_events
#
#  id          :integer         not null, primary key
#  status_name :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status_event do
    status_name "pending"
  end
end
