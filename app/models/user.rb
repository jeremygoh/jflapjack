class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :comments
  
  def email_required?
    false
  end
  
end
