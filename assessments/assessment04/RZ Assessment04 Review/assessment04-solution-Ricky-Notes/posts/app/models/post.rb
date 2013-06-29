class Post < ActiveRecord::Base
  attr_accessible :title, :body
  
  validates :title, :body, :user_id, :presence => true
  
  belongs_to :user
  has_many :tags
end
