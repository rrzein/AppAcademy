class User < ActiveRecord::Base
  attr_accessible :username, :password, :hero_ids
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

  has_many :admirations, :foreign_key => :hero_id, :class_name => "Friendship"
  has_many :friendships, :foreign_key => :admirer_id

  has_many :admirers,
  :through => :friendships,
  :source => :admirer

  has_many :heroes,
  :through => :admirations,
  :source => :hero

  validates :username, :password_digest, :presence => true

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
