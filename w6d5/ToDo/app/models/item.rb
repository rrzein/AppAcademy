class Item < ActiveRecord::Base
  attr_accessible :list_id, :name

  belongs_to :list

end
