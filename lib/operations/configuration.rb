# frozen_string_literal: true

module Operations
  class Configuration
    attr_accessor :primary_key_name, :primary_key_type, :foreign_key_suffix

    def initialize
      self.primary_key_name   = :id
      self.primary_key_type   = :integer
      self.foreign_key_suffix = "_id"
    end
  end
end
