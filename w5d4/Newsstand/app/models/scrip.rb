class Scrip < ActiveRecord::Base
  attr_accessible :plan_id, :reader_id

  belongs_to :plan,
  	:class_name => "SubscriptionPlan",
  	:foreign_key => :plan_id,
  	:inverse_of => :scrips

  belongs_to :reader,
  	:class_name => "User",
  	:foreign_key => :reader_id,
  	:inverse_of => :scrips

  has_one :newspaper,
    :through => :plan,
    :source => :newspaper,
    :inverse_of => :scrips
  	
end
