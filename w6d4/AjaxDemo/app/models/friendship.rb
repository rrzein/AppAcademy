class Friendship < ActiveRecord::Base
  attr_accessible :admirer_id, :hero_id

  belongs_to :admirer,
  :class_name => "User",
  :foreign_key => :admirer_id

  belongs_to :hero,
  :class_name => "User",
  :foreign_key => :hero_id

end
