class UserInterest < ActiveRecord::Base
	belongs_to :user
	belongs_to :interest
  attr_accessible :interest_id, :user_id
end
