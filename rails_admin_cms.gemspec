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

  s.add_development_dependency "sqlite3"
end
