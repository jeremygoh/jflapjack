class Post < ActiveRecord::Base
has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>", :square => "250>x250#", :large => "500x500>"}, :processors => [:cropper]

	before_create do |post|
     post.time = 86400
  end

end
