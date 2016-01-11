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
      :parent_mailer,
      :custom_form_max_size,
      :with_email_body
    )

    def parent_controller
      @parent_controller || ::ApplicationController
    end

    def parent_mailer
      @parent_mailer || "::ApplicationMailer".safe_constantize || BlackHole
    end

    def custom_form_max_size
      @custom_form_max_size || 20
    end

    def with_email_body?
      @with_email_body
    end
  end
end
