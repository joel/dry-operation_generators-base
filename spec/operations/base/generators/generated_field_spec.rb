# frozen_string_literal: true

module Operations
  module Base
    module Generators
      RSpec.describe GeneratedField do
        subject(:parsed_field) { described_class.parse(field) }

        [
          "name:string",
          "name:string{required: true}",
          "name:string{required: true, index: true}",
          "name:string{required,index}",
          "name:string{required}"
        ].each do |field|
          context "with valid field '#{field}'" do
            let(:field) { field }

            describe ".parse" do
              it "no raises error" do
                expect { parsed_field }.not_to raise_error
              end
            end
          end
        end

        [
          "name:unknown",
          "name:string{unknown: true}",
          "name:string{unknown}"
        ].each do |field|
          context "with invalid field '#{field}'" do
            let(:field) { field }

            describe ".parse" do
              it "raises error" do
                expect { parsed_field }.to raise_error(/Could not generate field/)
              end
            end
          end
        end

        context "with simple case" do
          let(:field) { "name:string" }

          describe ".parse" do
            it "returns a GeneratedField object" do
              expect(parsed_field).to be_a(described_class)
            end

            it "parses the name" do
              expect(parsed_field.name).to eq("name")
            end

            it "parses the type" do
              expect(parsed_field.type).to eq("string")
            end

            it "parses the attr_options" do
              expect(parsed_field.attr_options).to eq({})
            end
          end
        end

        context "with explicit options" do
          let(:field) { "name:string{required: true}" }

          describe ".parse" do
            it "returns a GeneratedField object" do
              expect(parsed_field).to be_a(described_class)
            end

            it "parses the name" do
              expect(parsed_field.name).to eq("name")
            end

            it "parses the type" do
              expect(parsed_field.type).to eq("string")
            end

            it "parses the attr_options" do
              expect(parsed_field.attr_options).to eq({ required: true })
            end
          end
        end

        context "with implicit options" do
          let(:field) { "name:string{required}" }

          describe ".parse" do
            it "returns a GeneratedField object" do
              expect(parsed_field).to be_a(described_class)
            end

            it "parses the name" do
              expect(parsed_field.name).to eq("name")
            end

            it "parses the type" do
              expect(parsed_field.type).to eq("string")
            end

            it "parses the attr_options" do
              expect(parsed_field.attr_options).to eq({ required: true })
            end
          end
        end

        context "with reference field" do
          let(:field) { "user:references{required}" }

          around(:all) do |each|
            current_foreign_key_suffix = Operations.configuration.foreign_key_suffix
            Operations.configure do |config|
              config.foreign_key_suffix = "_id"
            end
            each.run
            Operations.configure do |config|
              config.foreign_key_suffix = current_foreign_key_suffix
            end
          end

          describe ".parse" do
            it "returns a GeneratedField object" do
              expect(parsed_field).to be_a(described_class)
            end

            it "parses the name" do
              expect(parsed_field.name).to eq("user")
            end

            it "parses the type" do
              expect(parsed_field.type).to eq("references")
            end

            it "gives the foreign key name" do
              expect(parsed_field.foreign_key).to eq("user_id")
            end

            it "gives the class name" do
              expect(parsed_field.class_name).to eq("User")
            end

            it "parses the attr_options" do
              expect(parsed_field.attr_options).to eq({ required: true })
            end
          end
        end
      end
    end
  end
end
