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
          [:get, :post] # NEW / CREATE
        end

        register_instance_option :controller do
          proc do
            if request.get? # NEW

              @object = @abstract_model.new
              @authorization_adapter && @authorization_adapter.attributes_for(:new, @abstract_model).each do |name, value|
                @object.send("#{name}=", value)
              end
              if object_params = params[@abstract_model.to_param]
                @object.set_attributes(@object.attributes.merge(object_params))
              end

              respond_to do |format|
                format.html { render @action.template_name }
                format.js   { render @action.template_name, layout: false }
              end

            elsif request.post? # CREATE

              @modified_assoc = []
              @object = @abstract_model.new
              sanitize_params_for!(request.xhr? ? :modal : :create)

              @object.set_attributes(params[@abstract_model.param_key])
              @authorization_adapter && @authorization_adapter.attributes_for(:create, @abstract_model).each do |name, value|
                @object.send("#{name}=", value)
              end

              list_key_params = {
                  viewable_type: 'Viewable::Page',
                  view_path: @object.available_templates.sub('app/views/', '').sub('.html.erb', ''),
                  name: 'cms',
                  locale: I18n.locale
              }

              current_count = UniqueKey.where(list_key_params).count

              unique_key = list_key_params.merge(position: current_count + 1)

              viewable = UniqueKey.create_localized_viewable!(unique_key)

              path = rails_admin.edit_path(model_name: unique_key[:viewable_type].to_s.underscore.gsub('/', '~'),
                                           id: viewable.id,
                                           return_to: rails_admin.edit_path(model_name: unique_key[:viewable_type].to_s.underscore.gsub('/', '~')))

              redirect_to path
            end
          end
        end

        register_instance_option :link_icon do
          'icon-plus'
        end
      end
    end
  end
end
