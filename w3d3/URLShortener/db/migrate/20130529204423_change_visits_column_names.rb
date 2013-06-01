class ChangeVisitsColumnNames < ActiveRecord::Migration
  def change
    change_table :visits do |t|
      t.rename :shorturl_id, :short_url_id
      t.rename :longurl_id, :long_url_id
    end
  end
end
