class ChangeColumnFromAuthorToUserForPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :author_id
  	add_column :posts, :user_id, :integer
  end
end
