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

class User < ActiveRecord::Base
	attr_accessible :name, :email, :phone, :title, :organization, :address,
	                :city, :state, :zip

	validates :name, presence: true
	validates :email, presence: true
end
