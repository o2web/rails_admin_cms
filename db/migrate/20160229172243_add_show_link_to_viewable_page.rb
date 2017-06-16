class AddShowLinkToViewablePage < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :show_link, :boolean, default: true
  end
end
