class CreateCMSImages < ActiveRecord::Migration
  def up
    create_table :cms_images do |t|
      t.integer :page_id
      t.string :key

      t.timestamps null: false
    end
    CMS::Image.create_translation_table! title: :string,
                                          image: :string
  end
  def down
    CMS::Image.drop_translation_table!
    drop_table :cms_images
  end
end
