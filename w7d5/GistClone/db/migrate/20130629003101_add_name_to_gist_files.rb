class AddNameToGistFiles < ActiveRecord::Migration
  def change
    add_column :gist_files, :name, :string
  end
end
