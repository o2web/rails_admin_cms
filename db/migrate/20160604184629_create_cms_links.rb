class CreateCMSLinks < ActiveRecord::Migration
  def up
    create_table :cms_links do |t|
      t.integer :page_id
      t.string :key
      t.boolean :boolean
      t.boolean :turbolink

      t.timestamps null: false
    end
    CMS::Link.create_translation_table! title: :string,
                                        url: :string,
                                        page: :string,
                                        file: :string
  end
  def down
    CMS::Link.drop_translation_table!
    drop_table :cms_links
  end
end
