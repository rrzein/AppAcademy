class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :title, :null => false
      t.integer :todo_list_id, :null => false

      t.timestamps
    end

    add_index :todo_items, :todo_list_id
  end
end
