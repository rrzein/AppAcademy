class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :post_id
      t.string :name

      t.timestamps
    end
  end
end
