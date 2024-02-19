# frozen_string_literal: true

require "stringio"

module CaptureMixin
  def capture
    captured_output = StringIO.new
    original_stdout = $stdout
    $stdout = captured_output

    begin
      yield
      captured_output.string
    ensure
      $stdout = original_stdout
    end
  end
end

RSpec.configure do |config|
  config.include CaptureMixin
end
