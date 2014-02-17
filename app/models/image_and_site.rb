class ImageAndSite < ActiveRecord::Base
	belongs_to :image
	belongs_to :site
end
