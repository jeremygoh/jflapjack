class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :posts, dependent: :destroy
  has_many :comments

  # has_and_belongs_to_many :followers,
  #           class_name: 'User',
  #           foreign_key: 'following_id',
  #           association_foreign_key: 'user_id',
  #           join_table: 'followings_users'


  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

   has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :followed_posts, through: :relationships, source: :followed




  # def is_following?(user_id)
  #     following_ids.include?(user_id)
  # end
  

  def followed_posts
      self.followed_users.includes(:posts).order("updated_at desc").collect{|u| u.posts}.flatten 
  end


  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def followers
   Relationship.where("followed_id = #{self.id}").pluck(:follower_id)
  end


  # def follow(user_id)
  #   person_i_want_to_follow = User.find(user_id)
    
  #   unless person_i_want_to_follow.followers.include?(self)
  #     person_i_want_to_follow.followers << self
  #     person_i_want_to_follow.save
  #   end

  # end


  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end


 def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end



  def follow_user_by_comment(comment_id)
    author = Comment.find(comment_id).user
    self.follow!(author)
  end

  def email_required?
    false
  end

  def is_being_followed?(possible_follower)
    if self.following?(possible_follower)
      return "1"
    else
      return "0"
    end
  end
  
end
