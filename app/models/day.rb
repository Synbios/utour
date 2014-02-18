class Day < ActiveRecord::Base
	has_many :activities, :dependent => :destroy
	belongs_to :tour

	accepts_nested_attributes_for :activities, :reject_if => lambda { |a| a[:time].blank? }, :allow_destroy => true

	def generate_itinerary(force=false)
		if self.itinerary.blank? || force
			text = self.activities.map{ |activity| activity.short_des }.join(" ") 
			self.update_attributes(:itinerary => text)
		end
	end

	def des_by_site_names(sep="~")
		names = self.activities.where("site_id IS NOT NULL").map{ |activity| activity.site.name }.join(sep)
		if names.empty?
			names = self.itinerary
		end
		names
	end



	def number_of_tours
		self.activities.where(active_type: "1").count
	end
end
