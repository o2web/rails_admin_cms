Rails.application.routes.draw do
  scope module: 'cms' do
    get 'viewables/new' => 'viewables#create', format: false, as: :new_viewable
    post 'viewables/edit' => 'viewables#update', format: true, constraints: { format: :js }, as: :edit_viewable

    get 'attachments/*directory/:file' => 'attachments#show', format: true

    Viewable::Page.with_url.each do |page|
      get page.url => "pages#show", format: false, defaults: { id: page.id, cms_body_class: page.view_name, locale: page.locale }
    end if ActiveRecord::Base.connection.table_exists? 'viewable_pages'

    localized do
      resources :files, format: false, only: [:show]

      Viewable::Page.names.each do |name|
        get name => 'pages#show', format: false, defaults: { page: name, cms_body_class: name }
      end

      Form.names.each do |name|
        get name => 'forms#new', format: false, defaults: { form: name, cms_body_class: name }
        post name => 'forms#create', defaults: { form: name, cms_body_class: name }
      end
    end
  end
end
