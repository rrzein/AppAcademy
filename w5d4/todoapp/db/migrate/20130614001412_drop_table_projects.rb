class DropTableProjects < ActiveRecord::Migration
  def up
  	drop_table :projects
  end
end
