class PostShare < ActiveRecord::Base
  attr_accessible :friend_circle_id, :post_id

  belongs_to :post
  belongs_to :friend_circle
end
