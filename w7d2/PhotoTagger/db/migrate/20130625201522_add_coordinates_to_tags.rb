class AddCoordinatesToTags < ActiveRecord::Migration
  def change
    add_column :tags, :x, :integer
    add_column :tags, :y, :integer
  end
end
