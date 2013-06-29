class Tag < ActiveRecord::Base
  attr_accessible :name, :post_id

  belongs_to :post
end
