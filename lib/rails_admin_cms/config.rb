module RailsAdminCMS
  def self.config(&block)
    if block_given?
      block.call(RailsAdminCMS::Config)
    else
      RailsAdminCMS::Config
    end
  end

  module Config
    extend self

    attr_writer(
      :parent_controller,
      :authentication_method,
      :authorized_user_method,
      :parent_mailer,
      :with_paper_trail
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

    def with_paper_trail?
      @with_paper_trail
    end

    def base_path
      @base_path || ''
    end

    def base_path=(base_path)
      @base_path = base_path.split('/').compact.join('/')
    end
  end
end
