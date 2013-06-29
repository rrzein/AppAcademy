class Post < ActiveRecord::Base
  attr_accessible :body, :user_id, :links_attributes, :audience_circle_ids

  belongs_to :user
  has_many :links
  has_many :post_shares
  has_many :audience_circles, :through => :post_shares,
    source: :friend_circle

  has_many :up_votes

  accepts_nested_attributes_for :links,
    :reject_if => lambda { |attributes| attributes['name'].blank? }
end
