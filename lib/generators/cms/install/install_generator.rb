module Cms; end

class Cms::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc "Overwrite the existing Rails application with the necessary files"

  def copy_files
    directory 'app', 'app'
    directory 'config', 'config'
    directory 'vendor', 'vendor'
    copy_file 'Gemfile', 'Gemfile'
  end
end
