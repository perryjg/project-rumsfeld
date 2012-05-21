# == Schema Information
#
# Table name: letters
#
#  id          :integer         not null, primary key
#  request_id  :integer
#  letter_text :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Letter < ActiveRecord::Base
  belongs_to :user
  belongs_to :request_type
end
