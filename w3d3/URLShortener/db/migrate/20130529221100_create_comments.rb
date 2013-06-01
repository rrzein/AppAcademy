class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :short_url_id
      t.text :body
      t.integer :author_id

      t.timestamps
    end
  end
end
