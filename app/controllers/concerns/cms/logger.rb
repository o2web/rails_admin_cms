module CMS
  module Logger
    extend ActiveSupport

    protected

    def cms_logger(exception, log_name = nil)
      current_logger = log_name ? ::Logger.new("#{Rails.root}/log/#{log_name}.log") : logger
      current_logger.error ''
      current_logger.error "[EXCEPTION][#{request.remote_ip}][#{request.method}][#{request.original_url}]"
      if exception
        current_logger.error exception.message
        exception.backtrace.first(RailsAdminCMS::Config.exception_backtrace_size).each do |line|
          current_logger.error line
        end
      end
      current_logger.error '[END]'
      current_logger.error ''
    end
  end
end