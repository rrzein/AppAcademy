class Tagging < ActiveRecord::Base
  attr_accessible :shortened_url_id, :tag_id

  validates :shortened_url_id, :presence => true
  validates :tag_id, :presence => true
  # don't duplicate tag for a shortened_url
  validates :tag_id, :uniqueness => { :scope => :shortened_url_id }

  belongs_to :url, :class_name => "ShortenedUrl", :foreign_key => :shortened_url_id
  belongs_to :tag

  def self.affix_tag(url, tag)
    Tagging.create(:shortened_url_id => url.id, :tag_id => tag.id)
  end
end
