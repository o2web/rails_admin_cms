module CMS
  module Editing
    extend ActiveSupport::Concern

    included do
      before_action :set_edit_mode

      helper_method :cms_edit_mode?
    end

    def cms_edit_mode?
      @_editing ||= current_admin? && session[:edit_mode].to_b
    end

    private

    def set_edit_mode
      session[:edit_mode] = params[:edit_mode] || session[:edit_mode]
    end
  end
end
