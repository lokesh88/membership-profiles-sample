class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
    	
	attr_accessible :email, :password, :password_confirmation, 
		:remember_me, :avatar, :name, :location_country, :location_city
  # attr_accessible :title, :body

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

	validates_attachment :avatar, :presence => true,
		:content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
	validates :name, :location_country, :presence => true

	has_many :interests
	
  def self.search_result q
	return [] if q.blank?
	where("name like (?) OR email like (?)", "%#{q.split(' ').first}%", "%#{q.split(' ').first}%")
  end
end
