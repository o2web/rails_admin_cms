RailsAdmin.config do |config|
  config.main_app_name = ["Dashboard", ""]

  config.browser_validations = false

  config.compact_show_view = false

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  config.current_user_method(&:current_admin)

  config.authorize_with do
    redirect_to '/' unless current_admin?
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  if 'Spree::User'.safe_constantize # TODO: move to Solidus connector
    config.audit_with :paper_trail, 'Spree::User', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  else
    config.audit_with :paper_trail, 'BlackHole', 'PaperTrail::Version'
  end

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.included_models = Naming::Viewable.models + Naming::Form.models + %w[
    UniqueKey
    Setting
    Rich::RichFile
    CMS::Page
    CMS::Page::Translation
    CMS::Text
    CMS::Text::Translation
  ]

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except Naming::Viewable.models + Naming::Form.models + %w[
        UniqueKey
        Setting
        Rich::RichFile
        CMS::Text
      ]
    end
    export do
      except Naming::Viewable.models + Naming::Form.structure_models + %w[
        UniqueKey
      ]
    end
    bulk_delete do
      except Naming::Viewable.models + Naming::Form.structure_models + %w[
        UniqueKey
        Setting
      ]
    end
    show do
      except Naming::Viewable.models + Naming::Form.structure_models + %w[
        UniqueKey
      ]
    end
    edit do
      except %w[
        UniqueKey
      ]
    end
    delete do
      except Naming::Form.structure_models + %w[
        UniqueKey
        Setting
      ]
    end
    show_in_app

    create_page do
      visible do
        %w(
          Viewable::Page
        ).include? bindings[:abstract_model].model_name
      end
    end

    nestable do
      visible do
        %w(
          Viewable::Page
          CMS::Page
        ).include? bindings[:abstract_model].model_name
      end
    end

    ## With an audit adapter, you can add:
    history_index
    history_show
  end

  config.model 'Rich::RichFile' do
    navigation_label I18n.t('rich.file.navigation')
    label I18n.t('rich.file.one')
    label_plural I18n.t('rich.file.other')

    object_label_method do
      :name
    end

    configure :rich_file, :jcrop

    list do
      field :rich_file
      field :rich_file_file_name
      field :simplified_type
      field :owner_type
    end

    show do
      field :rich_file
      field :owner_type
    end

    edit do
      field :rich_file do
        fit_image true
      end
      field :owner_type, :enum do
        enum do
          ['cms']
        end
      end
    end
  end

  config.model 'CMS::Page::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :title, :url
  end

  config.model 'CMS::Text::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :title, :text
  end
end
