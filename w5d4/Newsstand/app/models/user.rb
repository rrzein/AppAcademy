class User < ActiveRecord::Base
  attr_accessible :name, :plan_ids

  validates :name, :presence => true

  has_one :newspaper,
  	:class_name => "Newspaper",
  	:foreign_key => :editor_id,
  	:inverse_of => :editor

  has_many :scrips,
  	:class_name => "Scrip",
  	:foreign_key => :reader_id,
  	:inverse_of => :reader

  has_many :plans,
  	:through => :scrips,
  	:source => :plan,
  	:inverse_of => :subscribers

  has_many :subscribed_newspapers,
  	:through => :plans,
  	:source => :newspaper,
  	:inverse_of => :readers


end
