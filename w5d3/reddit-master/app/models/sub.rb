class Sub < ActiveRecord::Base
  attr_accessible :name, :links_attributes
  
  belongs_to :moderator, :class_name => "User"
  has_many :link_posts, :dependent => :destroy
  has_many :links, :through => :link_posts
  
  validates :name, :moderator, :presence => true
  
  accepts_nested_attributes_for :links, :reject_if => :all_blank
end
