class CreateViewableLink < ActiveRecord::Migration
  def change
    create_table :viewable_links do |t|
      t.string     :title
      t.text       :link
      t.text       :page
      t.boolean    :target_blank, default: false
      t.boolean    :turbolink, default: true

      t.timestamps null: false
    end
  end
end
