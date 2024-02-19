# frozen_string_literal: true

# Extracted from rspec-rails spec/support/generators.rb
# https://github.com/rspec/rspec-rails/blob/v6.0.3/spec/support/generators.rb

module Specs
  module Generators
    module Macros
      extend ActiveSupport::Concern

      class_methods do
        # Tell the generator where to put its output (what it thinks of as Rails.root)
        def set_default_destination
          self.destination_root = File.expand_path("../../tmp", __dir__)
        end

        def setup_default_destination
          set_default_destination
          before { prepare_destination }
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Specs::Generators::Macros, type: :generator
end
