class Membership < ActiveRecord::Base
  attr_accessible :friend_circle_id, :member_id

  belongs_to :member,
    class_name: "User",
    foreign_key: :member_id
  belongs_to :friend_circle


end
