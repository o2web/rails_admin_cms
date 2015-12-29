Rails.application.routes.draw do
  get 'viewables/new' => 'cms/viewables#create', format: false, as: :new_viewable
  post 'viewables/edit' => 'cms/viewables#update', format: :json, as: :edit_viewable

  localized do
    get 'files/:id' => 'cms/files#show', format: false, as: :file

    Viewable.pages.each do |template|
      get template => 'cms/pages#show', defaults: { id: template, cms_body_class: template }, format: false
    end
  end
end
