# frozen_string_literal: true

require_relative "base/version"
require_relative "configure"

require "operations/base/generators/base_generator"

module Operations
  extend Configure
  module Base
    class Error < StandardError; end
    # Your code goes here...
  end
end
