module Parsing
  class BaseService
    private

    def log_event event = "", params = ""
      Rails.logger.info("### #{self.class.to_s} log event: #{event}, params: #{ params }")
    end
  end
end
