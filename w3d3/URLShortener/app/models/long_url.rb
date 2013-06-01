#WHAT DO YOU KNOW. THIS CLASS ISN'T EVEN NECESSARY.

class LongUrl < ActiveRecord::Base
  validates :url, :presence => true, :uniqueness => true
  validates :url, :length => { :maximum => 1024 }

  has_many :short_urls

  attr_accessible :url
end
