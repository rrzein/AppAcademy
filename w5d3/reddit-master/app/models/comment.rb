module BuildExtension
  def build(params = {})
    obj = super(params)
    obj.link = proxy_association.owner.link

    obj
  end

  def create!(params = {})
    obj = build(params)
    obj.save!
  end
end

class Comment < ActiveRecord::Base
  attr_accessible :body

  has_many(
    :child_comments,
    :class_name => "Comment",
    :foreign_key => "parent_comment_id",

    :extend => BuildExtension
  )
  belongs_to :link
  belongs_to :parent_comment, :class_name => "Comment"

  validates :link, :presence => true
end
