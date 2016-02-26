require "rails-i18n"
require "rails_admin"
require "rails_admin-i18n"
require "route_translator"

require "active_link_to"
require "youtube_addy"
require "rich"
require "paperclip"
require "rails_admin_jcrop"

require "simple_form"
require "active_type"
require "active_type/virtual_attributes_decorator"
require "email_validator"
require "country_select"
require "i18n_country_select"
require "invisible_captcha"
require "jquery-form-validator-rails"
require "bootstrap_flash_messages"

require "paper_trail"
require "rails_admin_history_rollback"
require "naught"
require "rails_admin_globalize_field"
require "rails_admin_nestable"
require "ancestry"

BlackHole = Naught.build do |config|
  config.black_hole
end

require "rails_admin_cms/engine"
require "rails_admin_cms/inflections"
require "rails_admin_cms/core_ext/boolean"
require "rails_admin_cms/config"
require "rails_admin_cms/utils"

module RailsAdminCMS
  module Config
    module Actions

      class CreatePage < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :controller do
          Proc.new do
            redirect_to(Rails.application.routes.url_helpers.new_viewable_path(list_key: {locale: I18n.locale,
                                                                                          name: 'cms',
                                                                                          view_path: 'cms/pages/page',
                                                                                          viewable_type: 'Viewable::Page'},
                                                                               max: 'Infinity'))
          end
        end

        register_instance_option :link_icon do
          'icon-plus'
        end
      end
    end
  end
end
