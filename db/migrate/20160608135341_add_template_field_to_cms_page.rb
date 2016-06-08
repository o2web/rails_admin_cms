class AddTemplateFieldToCMSPage < ActiveRecord::Migration
  def change
    add_column :cms_pages, :template, :string
  end
end
