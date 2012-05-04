# == Schema Information
#
# Table name: users
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  email        :string(255)
#  phone        :string(255)
#  title        :string(255)
#  organization :string(255)
#  address      :string(255)
#  city         :string(255)
#  state        :string(255)
#  zip          :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
