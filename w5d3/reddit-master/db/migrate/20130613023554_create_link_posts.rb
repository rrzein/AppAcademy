class CreateLinkPosts < ActiveRecord::Migration
  def change
    create_table :link_posts do |t|
      t.integer :sub_id, :null => false
      t.integer :link_id, :null => false

      t.timestamps
    end
  end
end
