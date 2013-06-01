class User < ActiveRecord::Base
  validate :email, :presence => true, :uniqueness => true

  has_many :visits
  has_many :short_urls
  has_many :comments

  #kidn of like an alias to ":short_url"
  has_many :visited_urls, :through => :visits, :source => :short_url

  attr_accessible :email
end
