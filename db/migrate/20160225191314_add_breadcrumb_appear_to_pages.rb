class AddBreadcrumbAppearToPages < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :breadcrumb_appear, :boolean, default: false
  end
end