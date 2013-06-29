class SubscriptionPlan < ActiveRecord::Base
  attr_accessible :daily, :newspaper_id, :price

  validates :newspaper, :price, :presence => true
  validates_inclusion_of :daily, :in => [true, false]

  belongs_to :newspaper,
  	:inverse_of => :plans

  has_many :scrips,
  	:class_name => "Scrip",
  	:foreign_key => :plan_id,
  	:inverse_of => :plan

  has_many :subscribers,
    :through => :scrips,
    :source => :reader,
    :inverse_of => :plans

  def type
  	daily ? "Daily" : "Weekly"
  end
end
