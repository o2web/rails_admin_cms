module CMS
  module Logger
    extend ActiveSupport

    protected

    def cms_logger(exception, log_name = nil)
      current_logger = log_name ? ::Logger.new("#{Rails.root}/log/#{log_name}.log") : logger
      current_logger.error "[ERROR][#{request.remote_ip}][#{request.method}][#{request.original_url}]"
      if exception
        current_logger.error exception.message
        exception.backtrace.each{ |line| current_logger.error line }
      end
    end
  end
end