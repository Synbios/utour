class Day < ActiveRecord::Base
	has_many :activities, :dependent => :destroy
	belongs_to :tour

	accepts_nested_attributes_for :activities, :reject_if => lambda { |a| a[:active_type].blank? }, :allow_destroy => true
end
