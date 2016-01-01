class CreateViewablePage < ActiveRecord::Migration
  def change
    create_table :viewable_pages do |t|
      t.string     :uuid
      t.text       :url,     index: true
      t.string     :title
      t.text       :meta_keywords
      t.text       :meta_description

      t.timestamps null: false
    end
  end
end
