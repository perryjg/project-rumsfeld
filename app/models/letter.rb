class Letter < ActiveRecord::Base
  belongs_to :user
  belongs_to :request_type
end
