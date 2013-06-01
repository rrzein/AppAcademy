class TagTopic < ActiveRecord::Base
  validates :name, :presence =>, :uniqueness => true

  has_many :taggings
  has_many :short_urls, :through => :taggings

  attr_accessible :name

  def tag_it(url)
    Tagging.tag_it(url, self)
  end
end
