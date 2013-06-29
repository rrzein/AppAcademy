class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id

  belongs_to :user,
  foreign_key: :user_id

  belongs_to :friend,
  class_name: "User",
  foreign_key: :friend_id
end
