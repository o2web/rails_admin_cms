class CreateViewableImage < ActiveRecord::Migration
  def change
    create_table :viewable_images do |t|
      t.string     :title
      t.text       :image

      t.timestamps null: false
    end
  end
end
