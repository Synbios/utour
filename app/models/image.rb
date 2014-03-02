class Image < ActiveRecord::Base
	validates :name, :presence => { :message => "图片名称为必填" }, :length => { :in => 1..128, :message => "图片名称过长" }
 
	has_attached_file :photo, :styles => { :medium => "300x300>", :small => '100x100>', :thumb => '100x100#' }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  has_many :image_and_sites, :dependent => :destroy
  has_many :sites, through: :image_and_sites
end
