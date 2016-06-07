class Product < ActiveRecord::Base
	has_attached_file :image, style: {medium: '1280x720', thumb: '200x100'}
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	#validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	#validates_attachment_content_type :image, content_type: ["image/jpeg"]
end
