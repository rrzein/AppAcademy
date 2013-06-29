class TodoList < ActiveRecord::Base
  attr_accessible :title

  has_many :todo_items

  validates :title, :presence => true
end
