# == Schema Information
#
# Table name: request_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  template   :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class RequestType < ActiveRecord::Base
end
