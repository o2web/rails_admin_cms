class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CMS::Localize
  include CMS::Editing
  include CMS::Authenticate
  include CMS::Logger
  include CMS::Rescue

  def paper_trail_enabled_for_controller
    false
  end
end
