Rails.application.routes.draw do
  get 'viewables/new' => 'cms/viewables#create', format: false, as: :new_viewable
  post 'viewables/edit' => 'cms/viewables#update', format: :json, as: :edit_viewable

  localized do
    Viewable.pages.each do |template|
      get "#{RailsAdminCMS::Config.base_path}/#{template}" => 'cms/pages#show', defaults: { id: template, cms_body_class: template }, format: false
    end
  end
end
