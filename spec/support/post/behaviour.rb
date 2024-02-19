# frozen_string_literal: true

# Extracted from Railties lib/rails/generators/testing/behaviour.rb
# https://github.com/rails/rails/blob/7-1-stable/railties/lib/rails/generators/testing/behavior.rb

require "active_support/core_ext/class/attribute"
require "active_support/core_ext/module/delegation"
require "active_support/core_ext/hash/reverse_merge"
require "active_support/core_ext/kernel/reporting"
require "active_support/concern"
require "rails/generators"

module Generators
  module Testing
    module Behaviour
      extend ActiveSupport::Concern

      included do
        # Generators frequently change the current path using +FileUtils.cd+.
        # So we need to store the path at file load and revert back to it after each test.
        class_attribute :current_path, default: File.expand_path(Dir.pwd)
        class_attribute :default_arguments, default: []
        class_attribute :destination_root
        class_attribute :generator_class
      end

      class_methods do
        # Sets which generator should be tested:
        #
        #   tests AppGenerator
        def tests(klass)
          self.generator_class = klass
        end

        # Sets default arguments on generator invocation. This can be overwritten when
        # invoking it.
        #
        #   arguments %w(app_name --skip-active-record)
        def arguments(array)
          self.default_arguments = array
        end

        # Sets the destination of generator files:
        #
        #   destination File.expand_path("../tmp", __dir__)
        def destination(path)
          self.destination_root = path
        end
      end

      def content_for(file_name)
        File.read("#{destination_root}/#{file_name}")
      end

      # Runs the generator configured for this class. The first argument is an array like
      # command line arguments:
      #
      #   class AppGeneratorTest < Rails::Generators::TestCase
      #     tests AppGenerator
      #     destination File.expand_path("../tmp", __dir__)
      #     setup :prepare_destination
      #
      #     test "database.yml is not created when skipping Active Record" do
      #       run_generator %w(myapp --skip-active-record)
      #       assert_no_file "config/database.yml"
      #     end
      #   end
      #
      # You can provide a configuration hash as second argument. This method returns the output
      # printed by the generator.
      def run_generator(args)
        capture do
          generator_instance(args).invoke_all
        end
      end

      def generator_instance(args = default_arguments, options = {}, config = {})
        @generator_instance ||= generator_class.new(args, options, config.reverse_merge(destination_root:))
      end

      private

      def destination_root_is_set?
        raise "You need to configure your Rails::Generators::TestCase destination root." unless destination_root
      end

      def ensure_current_path
        FileUtils.chdir current_path
      end

      # Clears all files and directories in destination.
      def prepare_destination
        ::FileUtils.rm_rf(destination_root)
        ::FileUtils.mkdir_p(destination_root)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Generators::Testing::Behaviour, type: :generator
end
