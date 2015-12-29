class CreateViewableLink < ActiveRecord::Migration
  def change
    create_table :viewable_links do |t|
      t.string     :title
      t.text       :url
      t.text       :page
      t.text       :file
      t.boolean    :target_blank, default: false
      t.boolean    :turbolink, default: true

      t.timestamps null: false
    end
  end
end
