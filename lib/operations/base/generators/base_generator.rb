# frozen_string_literal: true

require "active_support/concern"

require "operations/base/generators/generated_field"

module Operations
  module Base
    module Generators
      module BaseGenerator
        extend ActiveSupport::Concern

        def initialize(args, *options)
          super

          parse_fields!
        end

        included do
          argument :verb, type: :string, default: "create", desc: "CRUD verb"
          argument :fields, type: :array, default: [], banner: "field:type:requirement"

          class_option :component, type: :string, desc: "Component type"

          attr_accessor :regular_parsed_fields, :reference_parsed_fields, :parsed_fields, :root_file_path,
                        :root_test_file_path
        end

        def validate_verb_argument
          return if %w[create update destroy].include?(verb)

          raise Thor::Error, "Invalid verb: '#{verb}'. It should be either 'create', 'update' or 'destroy'."
        end

        def generate_files
          @root_file_path = "app"
          @root_file_path = "components/#{options[:component]}" if options[:component]

          @root_test_file_path = "test"
          @root_test_file_path = "test/components/#{options[:component]}" if options[:component]
        end

        private

        # Convert fields array into GeneratedField objects.
        def parse_fields!
          @parsed_fields           ||= []
          @regular_parsed_fields   ||= []
          @reference_parsed_fields ||= []

          fields.each do |field|
            parsed_field = GeneratedField.parse(field)

            parsed_fields           << parsed_field
            regular_parsed_fields   << parsed_field if parsed_field.regular?
            reference_parsed_fields << parsed_field if parsed_field.reference?
          end
        end
      end
    end
  end
end
