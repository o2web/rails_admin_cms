class CreateViewableImage < ActiveRecord::Migration
  def change
    create_table :viewable_images do |t|
      t.string     :title
      t.text       :image_path

      t.timestamps null: false
    end
  end
end
