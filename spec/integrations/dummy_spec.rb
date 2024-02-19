# frozen_string_literal: true

require "rails/generators"

class DummyGenerator < Rails::Generators::NamedBase
  include ::Operations::Base::Generators::BaseGenerator

  source_root File.expand_path("templates", __dir__)

  def generate_files
    super

    template "dummy_template.rb.erb.tt", "#{root_file_path}/operations/#{plural_name}/#{verb}/dummy.rb"
  end
end

RSpec.describe "Dummy", type: :generator do
  setup_default_destination

  tests DummyGenerator

  subject(:dummy_generator) do
    run_generator(args)
  end

  let(:args) do
    [
      "address",
      "create",
      "name:string{required}",
      "alias:string{optional}",
      "user:references{required}"
    ]
  end

  let(:dummy) { content_for("app/operations/addresses/create/dummy.rb") }

  it "fill the regular_parsed_fields" do
    generator = generator_instance(args)

    expect(generator.regular_parsed_fields).to contain_exactly(
      an_object_having_attributes(name: "name", type: "string", attr_options: { required: true }),
      an_object_having_attributes(name: "alias", type: "string", attr_options: { optional: true })
    )

    expect(generator.reference_parsed_fields).to contain_exactly(
      an_object_having_attributes(name: "user", type: "references", attr_options: { required: true })
    )
  end

  it "copy template" do
    dummy_generator

    expect(File).to exist("#{destination_root}/app/operations/addresses/create/dummy.rb")
  end

  it "is the expected initializer_types file" do
    dummy_generator

    expect(dummy).to match(/class AddressContract/)
  end

  it "generates dummy.rb with correct content" do
    dummy_generator

    expect(dummy).to eql(
      <<~DUMMY
         # frozen_string_literal: true

        class AddressContract < Dry::Validation::Contract
          schema do
            required(:name).value(:string)
            optional(:alias).value(:string)
            required(:user_uuid).value(:string)
          end

          rule(:user_uuid) do
            key.failure("must exist") if User.where(uuid: value).none?
          end

        end
      DUMMY
    )
  end
end
