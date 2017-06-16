class AddMetaTitleToViewablePages < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :meta_title, :string
  end
end