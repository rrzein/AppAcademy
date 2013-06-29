class AddOwnerToLinks < ActiveRecord::Migration
  def change
    add_column :links, :owner_id, :integer
  end
end
