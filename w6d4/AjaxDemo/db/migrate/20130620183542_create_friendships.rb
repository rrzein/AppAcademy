class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :admirer_id
      t.integer :hero_id

      t.timestamps
    end
  end
end
