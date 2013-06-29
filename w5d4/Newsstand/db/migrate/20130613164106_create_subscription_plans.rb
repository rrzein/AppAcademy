class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.integer :price
      t.boolean :daily
      t.integer :newspaper_id

      t.timestamps
    end
  end
end
