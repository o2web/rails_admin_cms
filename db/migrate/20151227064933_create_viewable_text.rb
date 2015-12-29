class CreateViewableText < ActiveRecord::Migration
  def change
    create_table :viewable_texts do |t|
      t.string     :title
      t.text       :text

      t.timestamps null: false
    end
  end
end
