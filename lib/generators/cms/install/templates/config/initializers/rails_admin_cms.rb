RailsAdminCMS.config do |config|
  # Defines the base controller inherited from
  # config.parent_controller = ::ApplicationController

  # Defines the base mailer inherited from
  # config.parent_mailer = ::ApplicationMailer

  # Defines the maximum number of fields a Form defined admin side has
  # * it is important to note that rake cms:adjust_max_size needs to be run if that number changes
  # config.custom_form_max_size = 20

  # Defines if Forms defined admin side need their body to be editable
  # config.with_email_body = false

  # Defines if there is the current locale in the locale selector
  # config.hide_current_locale = false

  # Defines iframe permissions: same host, different host or all
  # config.allow_iframe_from = 'SAMEORIGIN'
  # config.allow_iframe_from = 'ALLOW-FROM https://www.google.com'
  # config.allow_iframe_from = 'ALLOWALL'

  # Defines the number of lines picked from exception backtrace in 'cms_logger'
  # config.exception_backtrace_size = 10
end
