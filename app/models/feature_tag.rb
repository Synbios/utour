class FeatureTag < ActiveRecord::Base
	validates :name, :presence => { :message => "标签名称为必填" }, :uniqueness => { :message => "该标签已存在" }
end
