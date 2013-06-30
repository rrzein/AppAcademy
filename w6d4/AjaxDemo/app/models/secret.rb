class Secret < ActiveRecord::Base
  attr_accessible :title, :recipient_id, :tag_ids

  belongs_to :author, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  validates :title, :author, :recipient, :presence => true

  has_many :secret_taggings
  has_many :tags,
  :through => :secret_taggings,
  :source => :tag
end
