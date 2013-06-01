class Tagging < ActiveRecord::Base
  validates :short_url_id, :presence => true
  validates :tag_topic_id, :presence => true
  #doesn't duplicate tag for a shortened url
  validates :tag_topic_id, :uniqueness => { :scope => :shortened_url_id }

  belongs_to :tag_topic
  belongs_to :short_url

  attr_accessible :tag_topic_id, :short_url_id

  #need a way to put the tag on the shit.
  def self.tag_it(url, tag_topic)
    Tagging.create(:short_url_id => url.id, :tag_topic_id => tag_topic.id)
end
