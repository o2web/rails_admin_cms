$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_cms"
  s.version     = RailsAdminCMS::VERSION
  s.authors     = ["Patrice Lebel"]
  s.email       = ["patrice@lebel.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsAdminCMS."
  s.description = "TODO: Description of RailsAdminCMS."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "rails_admin"
  s.add_dependency "route_translator"
  s.add_dependency "jquery-rails"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency "active_link_to"
  s.add_dependency "youtube_addy"
  s.add_dependency "rich"
  s.add_dependency "paperclip", "~> 4.2"

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
end
