class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :url
      t.integer :longurl_id
      t.integer :visits
      t.integer :submitter_id

      t.timestamps
    end
  end
end
