class CreateScrips < ActiveRecord::Migration
  def change
    create_table :scrips do |t|
      t.integer :plan_id
      t.integer :reader_id

      t.timestamps
    end
  end
end
