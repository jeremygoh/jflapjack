class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :posts
  has_many :comments

  has_and_belongs_to_many :followers,
            class_name: 'User',
            foreign_key: 'following_id',
            association_foreign_key: 'user_id',
            join_table: 'followings_users'

  def is_following?(user_id)
      following_ids.include?(user_id)
  end
  
  def follow(user_id)
    self.followers << User.find(user_id)
    self.save
  end

  def follow_by_comment(comment_id)
    author = Comment.find(comment_id).user.id
    self.follow(author)
  end

  def email_required?
    false
  end
  
end
