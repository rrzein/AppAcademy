class List < ActiveRecord::Base
  attr_accessible :title, :user_id, :items_attributes

	has_many :items

	accepts_nested_attributes_for :items

	belongs_to :user,
	:inverse_of => :lists

end
