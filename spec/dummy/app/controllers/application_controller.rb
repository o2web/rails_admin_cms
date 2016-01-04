class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include CMS::Localize
  include CMS::Editing
  include CMS::Authenticate

  # rescue_from Exception, with: :debug_breakpoint

  def debug_breakpoint(exception = nil)
    exception
  end
end
