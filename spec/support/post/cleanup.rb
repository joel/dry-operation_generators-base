# frozen_string_literal: true

RSpec.configure do |config|
  config.after(:suite) do
    puts "Cleaning up tmp directory"
    FileUtils.rm_rf(File.expand_path("../../tmp", __dir__))
  end
end
