class User < ActiveRecord::Base
  [ :name,
    :email ].each { |field| attr_accessible field }

  validates :name, :presence => true
  validates :email, :uniqueness => true, :presence => true

  # Read about overriding defaults first in shortened_url.rb.
  has_many :submitted_urls, :class_name => "ShortenedUrl", :foreign_key => "submitter_id"
  has_many :visits
  # `:source => :shortened_url` says to use the `shortened_url`
  # association in the `Visit` class. If I had called this association
  # `shortened_urls`, Rails would by default use `Visit`'s
  # `shortened_url` association. However, I wanted to further
  # distinguish visited from submitted urls.
  has_many :visited_urls, :through => :visits, :source => :shortened_url
end
