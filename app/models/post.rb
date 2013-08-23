class Post < ActiveRecord::Base
has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>", :square => "250>x250#", :large => "500x500>"}, :processors => [:cropper]

has_many :comments
belongs_to :user

validates_presence_of :user_id

	before_create do |post|
     post.time = 86400
  end

  def last_comment
    self.comments.last.body unless self.comments.empty?
  end

  def self.followed_by(user)
  	followed_user_ids = user.followers.pluck(:id)	
    
  	where("user_id IN (:user_ids)", user_ids: (followed_user_ids << user.id))
  end

end

