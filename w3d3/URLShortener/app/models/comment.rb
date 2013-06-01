class Comment < ActiveRecord::Base
  belongs_to :short_url
  belongs_to :author, :class_name => "User"

  attr_accessible :body, :short_url_id, :author
end
