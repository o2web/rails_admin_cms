class CreateViewableForm < ActiveRecord::Migration
  def change
    create_table :viewable_forms do |t|
      t.references :structure, index: true

      t.string     :uuid,      index: true
      t.text       :url,       index: true
      t.string     :title
      t.text       :meta_keywords
      t.text       :meta_description

      t.timestamps null: false
    end
  end
end
