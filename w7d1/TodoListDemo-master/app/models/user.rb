class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password
  
  has_many(
    :authored_secrets,
    :class_name => "Secret",
    :foreign_key => "author_id"
  )
  has_many(
    :received_secrets,
    :class_name => "Secret",
    :foreign_key => "recipient_id"
  )
  
  validates :username, :password_digest, :presence => true
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
