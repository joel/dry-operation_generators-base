# frozen_string_literal: true

RSpec.describe Operations::Base do
  it "has a version number" do
    expect(Operations::Base::VERSION).not_to be_nil
  end
end
