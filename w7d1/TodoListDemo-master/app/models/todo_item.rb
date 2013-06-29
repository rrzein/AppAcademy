class TodoItem < ActiveRecord::Base
  attr_accessible :title

  belongs_to :todo_list
  
  validates :title, :todo_list, :presence => true
end
