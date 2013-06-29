class Item < ActiveRecord::Base
  attr_accessible :completed, :text, :title, :project_id

  validates :title, :presence => true
  validates_inclusion_of :completed, :in => [true, false]

  belongs_to :project

end
