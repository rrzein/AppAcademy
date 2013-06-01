class ShortUrl < ActiveRecord::Base
  validates :url, :long_url_id, :submitter_id, :presence => true
  validate :url_limit_5_in_last_5_minutes
  validates :submitter_id, :url_limit_5_in_last_5_minutes => true

  has_many :visits
  has_many :users, :through => :visits
  has_many :comments
  has_many :taggings
  has_many :tag_topics, :through => :taggings
  belongs_to :submitter, :class_name => "User", :foreign_key => "submitter_id"
  belongs_to :long_url

  before_validation :shorten_url

  # attr_accessible :long_url_id, :submitter_id, :user_id
  [ :long_url,
    :short_url,
    :submitter_id ]. each { |field| attr_accessible field }

  def url_limit_5_in_last_5_minutes
    if ShortUrl.where("created_at > ? AND submitter_id = ?", Time.now - 600, :submitter_id).length > 5
      record.errors[:submitter_id] << "Too many URLs too soon."
    end
  end

  def shorten_url
    #||= if not already set
    self.url ||= SecureRandom.urlsafe_base64[0..4]
  end

  def num_clicks
    visits.count
  end

  def unique_visits
    visits.count(:user_id, :distinct => true)
  end

  def last_10_minutes
    now = Time.now
    range = ((now - 10.minutes)..now)
    #created at falls within "range"
    #count of all distinct user_id's
    visits.where(:created_at => range).count(:user_id, :distinct => true)
    # Visit.where("created_at > ?", Time.now - 6000).length
  end

end