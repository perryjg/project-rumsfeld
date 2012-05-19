# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  phone           :string(255)
#  title           :string(255)
#  organization    :string(255)
#  address         :string(255)
#  city            :string(255)
#  state           :string(255)
#  zip             :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
	has_many :requests, dependent: :destroy
	has_secure_password
	attr_accessible :name, :email, :phone, :title, :organization, :address,
	                :city, :state, :zip, :password, :password_confirmation

	liquid_methods :name, :email, :phone, :title, :organization, :address,
                 :city, :state, :zip
  
	before_save { |user| user.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
	validates :name, presence: true
	validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true
end
