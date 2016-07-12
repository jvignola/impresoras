class Product < ActiveRecord::Base
	#has_attached_file :image, style: {medium: '1280x720', thumb: '200x100'}
	#validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	#validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	#validates_attachment_content_type :image, content_type: ["image/jpeg"]
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    #validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
    has_many :orders
    has_many :interactions

	def self.search(search)
	  if search
	  	self.where("name like ?", "%#{search}%")
	    #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end

end
