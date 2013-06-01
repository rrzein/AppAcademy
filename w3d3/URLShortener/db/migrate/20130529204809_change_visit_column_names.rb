class ChangeVisitColumnNames < ActiveRecord::Migration
  def change
    change_table :visits do |t|
      t.rename :long_url_id, :user_id
    end
  end
end
