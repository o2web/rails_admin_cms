class AddControllerAndActionToPages < ActiveRecord::Migration
  def change
    add_column :viewable_pages, :controller, :string, default: 'pages'
    add_column :viewable_pages, :action, :string, default: 'show'
  end
end
