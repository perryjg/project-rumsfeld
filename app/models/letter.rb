# == Schema Information
#
# Table name: letters
#
#  id                  :integer         not null, primary key
#  sender              :string(255)
#  sender_title        :string(255)
#  sender_organization :string(255)
#  sender_email        :string(255)
#  recipient           :string(255)
#  email               :string(255)
#  title               :string(255)
#  organization        :string(255)
#  address             :string(255)
#  city                :string(255)
#  state               :string(255)
#  zip                 :string(255)
#  final_text          :text
#  user_id             :integer
#  request_type_id     :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#  request_text        :text
#

class Letter < ActiveRecord::Base
  belongs_to :user
  belongs_to :request_type
end
