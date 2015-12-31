Rails.application.routes.draw do
  scope module: 'cms' do
    get 'viewables/new' => 'viewables#create', format: false, as: :new_viewable
    post 'viewables/edit' => 'viewables#update', format: true, constraints: { format: :js }, as: :edit_viewable

    get 'attachments/*directory/:id' => 'attachments#show', format: true

    localized do
      resources :files, format: false, only: [:show]

      Viewable.pages.each do |page|
        get page => 'pages#show', defaults: { id: page, cms_body_class: page }, format: false
      end

      Form.pages.each do |page|
        get page => 'forms#new', defaults: { id: page, cms_body_class: page }, format: false
        post page => 'forms#create', defaults: { id: page, cms_body_class: page }
      end
    end
  end
end
