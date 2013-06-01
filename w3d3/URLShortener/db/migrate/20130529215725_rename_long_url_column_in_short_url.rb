class RenameLongUrlColumnInShortUrl < ActiveRecord::Migration
  def change
    change_table :short_urls do |t|
      t.rename :longurl_id, :long_url_id
    end
  end
end
