module RailsAdminCMS
  module Config
    extend self

    attr_writer(
      :parent_controller,
      :authentication_method,
      :authorized_user_method,
      :parent_mailer
    )

    def parent_controller
      @parent_controller || ::ApplicationController
    end

    def authentication_method
      @authentication_method || :authenticate_admin_user!
    end

    def authorized_user_method
      @authorized_user_method || :current_admin
    end

    def parent_mailer
      @parent_mailer || ::ApplicationMailer
    end
  end
end
