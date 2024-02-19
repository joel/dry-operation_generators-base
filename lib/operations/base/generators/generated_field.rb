# frozen_string_literal: true

require "active_support/inflector"

module Operations
  module Base
    module Generators
      class GeneratedField
        class InvalidTypeFieldError < StandardError; end
        class InvalidOptionFieldError < StandardError; end
        class MalformedFieldError < StandardError; end

        AVAILABLE_TYPES = %w[
          integer
          string
          text
          time
        ].freeze
        private_constant :AVAILABLE_TYPES

        AVAILABLE_ASSOCIATIONS = %w[
          belongs_to
          references
        ].freeze
        private_constant :AVAILABLE_ASSOCIATIONS

        AVAILABLE_OPTIONS = %w[
          required
          optional
          index
          foreign_key
          null
          default
        ].freeze
        private_constant :AVAILABLE_OPTIONS

        attr_accessor :name, :type, :attr_options

        class << self
          def parse(field)
            unless field.match?(/^[a-z_]+:[a-z_]+(\{([a-z:,\s]+)\})?$/)
              raise MalformedFieldError,
                    "Could not generate field '#{field}', it should be in the format 'name:type{options}'."
            end

            name, type = field.split(":", 2)

            type, attr_options = *parse_type_and_options(type)

            if invalid_type?(type)
              raise InvalidTypeFieldError,
                    "Could not generate field '#{name}' with unknown type '#{type}'."
            end

            if invalid_option?(attr_options)
              raise InvalidOptionFieldError,
                    "Could not generate field '#{name}' with unknown options '#{attr_options}'."
            end

            new(name, type, attr_options)
          end

          def invalid_type?(type)
            (AVAILABLE_TYPES + AVAILABLE_ASSOCIATIONS).exclude?(type.to_s)
          end

          def invalid_option?(options)
            return false if options.empty?

            !AVAILABLE_OPTIONS.intersect?(options.keys.map(&:to_s))
          end

          private

          def parse_type_and_options(type)
            case type
            when Regexp.new("(#{(AVAILABLE_TYPES + AVAILABLE_ASSOCIATIONS).join("|")}){(.+)}")
              options = Regexp.last_match(2).split(",").each_with_object({}) do |option, str_options|
                if option.include?(":")
                  key, value = option.split(":").map(&:strip)
                  str_options[key.to_sym] = case value
                                            when "true"
                                              true
                                            when "false"
                                              false
                                            else
                                              value
                                            end
                else
                  str_options[option.to_sym] = true
                end
              end

              [Regexp.last_match(1), options]
            else
              [type, {}]
            end
          end
        end

        def initialize(name, type = nil, options = {})
          @name         = name
          @type         = type || :string
          @attr_options = options
        end

        def requirement
          return "required" if attr_options[:required]

          "optional"
        end

        def reference?
          AVAILABLE_ASSOCIATIONS.include?(type.to_s)
        end
        alias association? reference?

        def regular?
          !reference?
        end

        def class_name
          name.classify
        end

        def foreign_key
          "#{name}#{Operations.configuration.foreign_key_suffix}"
        end
      end
    end
  end
end
