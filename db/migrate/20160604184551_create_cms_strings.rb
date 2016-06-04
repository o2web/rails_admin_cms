class CreateCMSStrings < ActiveRecord::Migration
  def up
    create_table :cms_strings do |t|
      t.integer :page_id
      t.string :key

      t.timestamps null: false
    end
    CMS::String.create_translation_table! string: :string
  end
  def down
    CMS::String.drop_translation_table!
    drop_table :cms_strings
  end
end
