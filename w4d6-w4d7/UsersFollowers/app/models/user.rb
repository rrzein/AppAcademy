class User < ActiveRecord::Base

  attr_accessible :name, :password, :username, :session_token
  has_many :followings
  has_many :followers, :through => :followings, :source => :follower

  has_many :friends, :class_name => 'Following', :foreign_key => :follower_id
  has_many :followees, :through => :friends, :source => :user

  def generate_session_token
    self.session_token = SecureRandom.urlsafe_base64(32)
    self.save!
  end

  def verify_password(password)
    self.password == password
  end

  def follow_user(followee)
    Following.new(:user_id => followee.id, :follower_id => self.id)
  end

  def following?(user)
    Following.where(:user_id => user.id, :follower_id => self.id)
  end

  def clear_session_token
    self.session_token = nil
    self.save!
  end

end
