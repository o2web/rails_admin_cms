class CreateCMSSelects < ActiveRecord::Migration
  def up
    create_table :cms_selects do |t|
      t.integer :page_id
      t.string :key

      t.timestamps null: false
    end
    CMS::Select.create_translation_table! label: :string,
                                          value: :string
  end
  def down
    CMS::Select.drop_translation_table!
    drop_table :cms_selects
  end
end
