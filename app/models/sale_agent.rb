class SaleAgent < ActiveRecord::Base
	belongs_to :agent, :class_name => 'Account'
  belongs_to :sale, :class_name => 'Account'
end
