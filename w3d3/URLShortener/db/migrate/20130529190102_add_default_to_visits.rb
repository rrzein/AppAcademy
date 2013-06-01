class AddDefaultToVisits < ActiveRecord::Migration
  def up
    remove_column("short_urls", "visits")
  end

  def down
    add_column("short_urls", "visits", "integer")
  end
end
