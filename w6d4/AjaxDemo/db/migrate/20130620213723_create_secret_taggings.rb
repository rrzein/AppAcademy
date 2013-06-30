class CreateSecretTaggings < ActiveRecord::Migration
  def change
    create_table :secret_taggings do |t|
      t.integer :tag_id
      t.integer :secret_id

      t.timestamps
    end
  end
end
