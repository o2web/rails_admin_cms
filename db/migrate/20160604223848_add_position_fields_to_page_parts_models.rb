class AddPositionFieldsToPagePartsModels < ActiveRecord::Migration
  def change
    add_column :cms_images, :position, :integer, default: 1
    add_column :cms_links, :position, :integer, default: 1
    add_column :cms_selects, :position, :integer, default: 1
    add_column :cms_strings, :position, :integer, default: 1
    add_column :cms_texts, :position, :integer, default: 1
  end
end
