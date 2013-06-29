class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password
  
  validates :username, :password_digest, :presence => true
  validate :password_is_long_enough
  
  has_many :links, :foreign_key => "owner_id"
  has_many :subs, :foreign_key => "moderator_id"
  
  def password=(password)
    @password = password

    self.password_digest = BCrypt::Password.create(password)
  end
  
  def verify_password(password)    
    BCrypt::Password.new(password_digest) == password
  end
  
  private
  def password_is_long_enough
    return if @password.nil?
    
    if @password.length < 6
      errors[:password] << "is not long enough"
    end
  end
end
