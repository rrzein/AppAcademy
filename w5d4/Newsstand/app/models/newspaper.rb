class Newspaper < ActiveRecord::Base
  attr_accessible :editor_id, :title, :plans_attributes

  validates :title, :editor, :presence => true
  validates :title, :uniqueness => true

  belongs_to :editor,
  	:class_name => "User",
  	:foreign_key => :editor_id,
  	:inverse_of => :newspaper

  has_many :plans,
  	:class_name => "SubscriptionPlan",
  	:foreign_key => :newspaper_id,
  	:inverse_of => :newspaper

  has_many :scrips,
  	:through => :plans,
  	:source => :scrips,
  	:inverse_of => :newspaper

  has_many :readers,
  	:through => :scrips,
  	:source => :reader,
  	:inverse_of => :subscribed_newspapers

  accepts_nested_attributes_for :plans,
  	:reject_if => lambda { |attributes| attributes["price"].blank? }

end
