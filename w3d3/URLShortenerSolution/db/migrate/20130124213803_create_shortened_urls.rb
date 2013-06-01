class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url

      t.integer :submitter_id

      t.timestamps
    end
  end
end
