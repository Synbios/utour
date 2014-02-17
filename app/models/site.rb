class Site < ActiveRecord::Base
	#attr_accessible :image_and_sites_attributes
	has_many :image_and_sites, :dependent => :destroy
	has_many :images, through: :image_and_sites

	accepts_nested_attributes_for :image_and_sites, :reject_if => lambda { |a| a[:image_id].blank? }, :allow_destroy => true
end
