class Gist < ActiveRecord::Base
  attr_accessible :title, :user_id, :gist_files_attributes

  validates :title, :user_id, :presence => true

  has_many :favorites

  has_many :gist_files,
  :dependent => :destroy,
  :inverse_of => :gist

  accepts_nested_attributes_for :gist_files

  belongs_to :user

end
