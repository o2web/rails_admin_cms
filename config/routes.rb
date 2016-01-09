Rails.application.routes.draw do
  scope module: 'cms' do
    get 'viewables/new' => 'viewables#create', format: false, as: :new_viewable
    post 'viewables/edit' => 'viewables#update', format: true, constraints: { format: :js }, as: :edit_viewable

    get 'attachments/*directory/:file' => 'attachments#show', format: true

    Viewable::Page.with_url.each do |page|
      get page.url => "pages#show", format: false,
        defaults: { id: page.id, cms_view_type: page.view_name, cms_body_class: page.view_name, locale: page.locale }
    end if ActiveRecord::Base.connection.table_exists? 'viewable_pages'

    Viewable::Form.with_url.each do |form|
      get form.url => "forms#new", format: false,
        defaults: { id: form.id, cms_view_type: form.form_name, cms_body_class: form.form_name, locale: form.locale }
      post form.url => 'forms#create',
        defaults: { id: form.id, cms_view_type: form.form_name, cms_body_class: form.form_name, locale: form.locale }
    end if ActiveRecord::Base.connection.table_exists? 'viewable_forms'

    localized do
      resources :files, format: false, only: [:show]

      Naming::Viewable::Page.names.each do |name|
        get name => 'pages#show', format: false,
          defaults: { cms_view_type: name, cms_body_class: name }
      end

      Naming::Viewable::Form.names.each do |name|
        get name => 'forms#new', format: false,
          defaults: { cms_view_type: name, cms_body_class: name }
        post name => 'forms#create',
          defaults: { cms_view_type: name, cms_body_class: name }
      end
    end
  end
end
