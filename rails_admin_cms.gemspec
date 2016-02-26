$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_cms"
  s.version     = RailsAdminCMS::VERSION
  s.authors     = ["Patrice Lebel"]
  s.email       = ["patrice@lebel.com"]
  s.homepage    = "https://github.com/o2web/rails_admin_cms"
  s.summary     = "Flexible Content Management Framework for RailsAdmin"
  s.description = "Flexible Content Management Framework for RailsAdmin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2", ">= 4.2.0"
  s.add_dependency "rails-i18n", "~> 4.0", ">= 4.0.8"
  s.add_dependency "rails_admin", "~> 0.8", ">= 0.8.1"
  s.add_dependency "rails_admin-i18n", "~> 0.0", ">= 0.0.9"
  s.add_dependency "route_translator", "~> 4.2", ">= 4.2.2"
  s.add_dependency "jquery-rails", "~> 4.0", ">= 4.0.5"
  s.add_dependency "jquery-ui-rails", "~> 5.0", ">= 5.0.5"

  s.add_dependency "active_link_to", "~> 1.0", ">= 1.0.3"
  s.add_dependency "youtube_addy", "~> 1.0", ">= 1.0.4"
  s.add_dependency "rich"
  s.add_dependency "paperclip", "~> 4.2"
  s.add_dependency "rails_admin_jcrop"

  s.add_dependency "simple_form", "~> 3.2", ">= 3.2.1"
  s.add_dependency "active_type", "~> 0.4", ">= 0.4.3"
  s.add_dependency "email_validator", "~> 1.6", ">= 1.6.0"
  s.add_dependency "country_select", "~> 2.5", ">= 2.5.1"
  s.add_dependency "i18n_country_select", "~> 1.1", ">= 1.1.5"
  s.add_dependency "invisible_captcha", "~> 0.8", ">= 0.8.0"
  s.add_dependency "jquery-form-validator-rails", "~> 0.0", ">= 0.0.2"
  s.add_dependency "bootstrap_flash_messages", "~> 1.0", ">= 1.0.1"
  s.add_dependency "gibbon", "~> 1.1"

  s.add_dependency "paper_trail", "~> 4.0.0"
  s.add_dependency "rails_admin_history_rollback", "~> 0.0.6"
  s.add_dependency "naught", "~> 1.0.0"
  s.add_dependency "rails_admin_globalize_field", "~> 0.4.0"
  s.add_dependency "rails_admin_nestable", "~> 0.3.2"
  s.add_dependency "ancestry", "~> 2.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "faker"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "spring"
  s.add_development_dependency "spring-commands-rspec"
  s.add_development_dependency "quiet_assets"
  s.add_development_dependency "yaml_db"
  s.add_development_dependency "letter_opener"
  s.add_development_dependency "letter_opener_web", "~> 1.2.0"
end
