class Project < ActiveRecord::Base
  attr_accessible :team_id, :text, :title

  validates :title, :presence => true

  has_many :items

end
