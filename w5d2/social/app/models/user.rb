require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :name, :password, :session_token, :username, :posts_attributes

  validates :name, :username, :presence => true
  validates :username, :uniqueness => true

  has_many :posts
  has_many :links, :through => :posts

  has_many :up_votes

  accepts_nested_attributes_for :posts

  # as Friend Circle creator
  has_many :friend_circles
  has_many :friendships, :through => :friend_circles,
    source: :memberships
  has_many :friends, :through => :friendships,
    source: :members

  # as Friend Circle member
  has_many :memberships,
    foreign_key: :member_id
  has_many :social_circles, :through => :memberships,
    source: :friend_circle
  has_many :social_leaders, :through => :social_circles,
    source: :user

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def verify_password(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  #could also put in setting session token for user and session in a single login user method that goes into the application controller

  def reset_session_token!
    self.session_token = SecureRandom::base64(32)
    self.save!

    self.session_token
  end

  def logout
    self.session_token = nil
    self.save!
  end
end
