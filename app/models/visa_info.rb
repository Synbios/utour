class VisaInfo < ActiveRecord::Base
  has_attached_file :form, :default_url => "missing"
end
