class Tag < ActiveRecord::Base
  attr_accessible :friend_id, :photo_id, :x, :y

  validates :friend_id, :presence => true

  belongs_to :photo
  belongs_to :friend,
    :class_name => "User",
    :foreign_key => :friend_id
end
