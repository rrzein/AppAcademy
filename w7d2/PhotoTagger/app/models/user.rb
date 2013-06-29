require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :name, :password, :session_token

  validates :name, :password_digest, :presence => true
  validates :name, :uniqueness => true

  has_many :friendships,
    :foreign_key => :user_id

  has_many :friends,
    :through => :friendships,
    :source => :friend

  has_many :followings,
    :class_name => "Friendship",
    :foreign_key => :friend_id

  has_many :followers,
    :through => :followings,
    :source => :user

  has_many :photos

  has_many :tags,
    :foreign_key => :friend_id

  has_many :tagged_photos,
    :through => :tags,
    :source => :photo

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def verify_password(password)
    BCrypt::Password.new(self.password_digest) == password
  end
end
