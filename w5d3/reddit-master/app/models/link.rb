class Link < ActiveRecord::Base
  attr_accessible :url, :sub_ids

  has_many :comments
  belongs_to :owner, :class_name => "User"
  has_many :link_posts
  has_many :subs, :through => :link_posts

  before_destroy :cleanup

  validates :url, :presence => true

  def comments_by_parent
    comments_by_parent = Hash.new { |hash, key| hash[key] = [] }
    comments.each do |comment|
      comments_by_parent[comment.parent_comment_id] << comment
    end

    comments_by_parent
  end

  private
  def cleanup
    link_posts.each do |lp|
      # optimization to more quickly drop LinkPosts
      lp.link = nil
      lp.destroy
    end
  end
end
