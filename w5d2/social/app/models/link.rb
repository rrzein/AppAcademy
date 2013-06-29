class Link < ActiveRecord::Base
  attr_accessible :name, :post_id

  belongs_to :post
end
