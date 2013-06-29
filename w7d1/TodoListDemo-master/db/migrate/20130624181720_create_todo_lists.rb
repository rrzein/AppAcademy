class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :title, :null => false

      t.timestamps
    end
  end
end
