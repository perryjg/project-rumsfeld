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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status do
    status "MyString"
    request
  end
end
