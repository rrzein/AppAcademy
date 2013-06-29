class User < ActiveRecord::Base
  attr_accessible :username, :password
  
  validates :username, :password, :presence => true
  validate :password_long_enough!

  has_many :posts

  private
  def password_long_enough!
    if password.length < 6
      errors[:password] << "Password is too short"
    end
  end
end
