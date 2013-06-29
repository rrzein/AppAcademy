class User < ActiveRecord::Base
  attr_accessible :name, :password

  validates :name, :password_digest, :presence => true

  has_many :subscriptions

  has_many :feeds,
  	:through => :subscriptions,
  	:inverse_of => :readers

	has_many :viewed_entries,
		:through => :feeds,
		:source => :entries

  def password=(password)
  	self.password_digest = BCrpypt::Password.create(password)
  end

  def verify_password(password)
  	BCrypt::Password.new(self.password_digest) == password
  end

end
