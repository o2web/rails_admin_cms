module CMS
  module Localize
    extend ActiveSupport::Concern

    included do
      before_action :set_locale
    end

    private

    def set_locale
      I18n.locale = session[:locale] = params[:locale] || session[:locale] || I18n.default_locale
    end
  end
end
