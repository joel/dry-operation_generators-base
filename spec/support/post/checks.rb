# frozen_string_literal: true

# Extracted from Railties lib/rails/generators/testing/setup_and_teardown.rb
# https://github.com/rails/rails/blob/7-1-stable/railties/lib/rails/generators/testing/setup_and_teardown.rb

RSpec.configure do |config|
  config.before do |example|
    next if example.metadata[:type] != :generator

    destination_root_is_set?
    ensure_current_path
  end

  config.after do |example|
    next if example.metadata[:type] != :generator

    ensure_current_path
  end
end
