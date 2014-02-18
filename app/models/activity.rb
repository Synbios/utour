class Activity < ActiveRecord::Base
	belongs_to :day
	belongs_to :site
	belongs_to :image
end
