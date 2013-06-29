class Favorite < ActiveRecord::Base
  attr_accessible :gist_id, :user_id

  validates :gist_id, :user_id, :presence => true
  validates :gist_id, :uniqueness => true

  belongs_to :user
  belongs_to :gist

end
