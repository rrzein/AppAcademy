class CreateUpVotes < ActiveRecord::Migration
  def change
    create_table :up_votes do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
