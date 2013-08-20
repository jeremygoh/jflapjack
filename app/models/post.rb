class Post < ActiveRecord::Base
has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>", :square => "250x250>"}

has_many :comments

	before_create do |post|
     post.time = 86400
  end

  def last_comment
    self.comments.last.body unless self.comments.empty?
  end

end
