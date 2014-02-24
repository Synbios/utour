class Departure < ActiveRecord::Base
	has_many :prices, :dependent => :destroy
	belongs_to :tour
	belongs_to :user_group
	belongs_to :account
end
