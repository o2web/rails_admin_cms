class AddShowLinkFieldToCMSPage < ActiveRecord::Migration
  def change
    add_column :cms_pages, :show_link, :boolean, default: false
    add_column :cms_pages, :breadcrumb_appear, :boolean, default: false
  end
end
