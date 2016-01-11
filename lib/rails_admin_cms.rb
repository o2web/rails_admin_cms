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

BlackHole = Naught.build do |config|
  config.black_hole
end

require "rails_admin_cms/engine"
require "rails_admin_cms/inflections"
require "rails_admin_cms/core_ext/boolean"
require "rails_admin_cms/config"
require "rails_admin_cms/utils"

require "rails_admin/application_controller_decorator"
require "rails_admin/form_builder_decorator"

module RailsAdminCMS
end
