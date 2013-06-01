class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :shorturl_id
      t.integer :longurl_id

      t.timestamps
    end
  end
end
