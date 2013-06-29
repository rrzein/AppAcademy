class Post < ActiveRecord::Base
  attr_accessible :body, :title, :user_id

  validates :body, :presence => true
  validates :title, :presence => true

  belongs_to :user, :class_name => "User"
  has_many :tags
end
