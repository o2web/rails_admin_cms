class CreateCMSTexts < ActiveRecord::Migration
  def up
    create_table :cms_texts do |t|
      t.integer :page_id
      t.integer :position
      t.string :key

      t.timestamps null: false
    end
    CMS::Text.create_translation_table! title: :string,
                                        text: :text
  end
  def down
    CMS::Text.drop_translation_table!
    drop_table :cms_pages
  end
end
