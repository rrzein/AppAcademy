class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :text
      t.boolean :completed

      t.timestamps
    end
  end
end
