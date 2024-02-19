# frozen_string_literal: true

require_relative "configuration"

module Operations
  module Configure
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
