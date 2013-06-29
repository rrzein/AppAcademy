class CreateNewspapers < ActiveRecord::Migration
  def change
    create_table :newspapers do |t|
      t.string :title
      t.integer :editor_id

      t.timestamps
    end
  end
end
