class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password
  
  has_many :lists,
  :inverse_of => :user

  has_many :list_items,
    :through => :lists,
    :source => :items
  
  validates :username, :password_digest, :presence => true
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
