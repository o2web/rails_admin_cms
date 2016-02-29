class AddHasShowPageToViewablePage < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :has_show_page, :boolean, default: false
  end
end
