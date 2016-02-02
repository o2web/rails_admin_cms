module CMS
  module Rescue
    extend ActiveSupport

    skip_filter *_process_action_callbacks.map(&:filter), only: [:render_404, :render_500]

    rescue_from Exception, with: :render_500 unless Rails.env.development?

    def render_404
      render file: 'public/404.html', status: 404, layout: false
    end

    def render_500(exception = nil)
      cms_logger exception
      self.response_body = nil # make sure that there is no DoubleRenderError
      render file: 'public/500.html', status: 500, layout: false
    end
  end
end
