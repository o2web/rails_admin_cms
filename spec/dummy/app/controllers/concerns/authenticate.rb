module Authenticate
  extend ActiveSupport::Concern

  included do
    # http_basic_authenticate_with name: 'user', password: 'pwd' if Rails.env.staging?

    helper_method :current_user, :current_user?, :current_admin, :current_admin?
  end

  # TODO override or rewrite
  def current_user
    @current_user ||= Struct.new(:admin?).new(true)
  end

  def current_user?
    return @is_current_user if defined? @is_current_user
    @is_current_user = !!current_user
  end

  def current_admin
    current_user if current_admin?
  end

  def current_admin?
    return @is_current_admin if defined? @is_current_admin
    @is_current_admin = !!current_user.try(:admin?)
  end

  def authenticate_admin_user!
    raise SecurityError unless current_admin?
  end
end
