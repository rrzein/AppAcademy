class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  has_many :taggings
  has_many :urls, :through => :taggings

  def affix(url)
    # this is a convenience
    Tagging.affix_tag(url, tag)
  end

  def n_plus_one_most_popular_url
    top_url, max_visits = nil, 0

    # one query to get the urls for this tag
    urls.each do |url|
      # one query each to get the visits for the url
      url_visits = url.visits.count
      top_url, max_visits = url, url_visits if url_visits > max_visits
    end

    top_url
  end

  def includes_most_popular_url
    top_url, max_visits = nil, 0

    # one query to get the urls for this tag; also fetch the visits at
    # the same time.
    urls = urls.include(:visits)

    urls..each do |url|
      # request for visits does not fire a db query
      url_visits = url.visits.count
      top_url, max_visits = url, url_visits if url_visits > max_visits
    end

    top_url
  end

  def most_popular_url
    # both previous ways fetch all the visits; this may be a lot of
    # data for the db to send the rails app.

    # Here's how to get the db to do the work of aggregating the
    # visits for us; no visit data is sent back from the db to the
    # rails app.
    urls
      .joins(:visits)
      .group("shortened_urls.id")
      .order("COUNT(*) DESC")
      .limit(1)
    # SELECT urls.*
    #   FROM urls
    #   JOIN visits
    #     ON visits.url_id = urls.id
    #  WHERE urls.tag_id = #{self.id}
    #  GROUP BY urls.id
    #  ORDER BY COUNT(*)
    #  LIMIT 1;
  end
end
