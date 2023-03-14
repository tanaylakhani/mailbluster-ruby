require "spec_helper"

RSpec.describe Mailbluster::Resource do
  context "with resource_type = fields" do
    describe "#create" do
      it "creates a field" do
        VCR.use_cassette("fields/create") do
          mailbluster_client = Mailbluster::Client.new

          create_field_attributes = {
            "fieldLabel" => "Gender",
            "fieldMergeTag" => "gender"
          }

          created_field = mailbluster_client.fields.create(
            create_field_attributes
          )

          expect(created_field).to be_a(described_class)
          expect(created_field.raw_attributes).to include("id")
          expect(created_field.raw_attributes).to include("fieldLabel")
          expect(created_field.raw_attributes["fieldLabel"]).to eq("Gender")
          expect(created_field.field_label).to eq("Gender")
        end
      end
    end

    describe "#read" do
      it "reads a field" do
        VCR.use_cassette("fields/read") do
          mailbluster_client = Mailbluster::Client.new

          found_fields = mailbluster_client.fields.read
          expect(found_fields).to be_a(Array)
          expect(found_fields.length).to eq(1)

          found_field = found_fields.first

          expect(found_field).to be_a(described_class)
          expect(found_field.raw_attributes).to include("id")
          expect(found_field.raw_attributes).to include("fieldLabel")
          expect(found_field.raw_attributes["fieldLabel"]).to eq("Gender")
          expect(found_field.field_label).to eq("Gender")
        end
      end
    end

    describe "#update" do
      it "updates a field" do
        VCR.use_cassette("fields/update") do
          mailbluster_client = Mailbluster::Client.new

          updated_field = mailbluster_client.resource("fields").update(
            1653,
            {
              "fieldLabel" => "Gender",
              "fieldMergeTag" => "gender"
            }
          )
          expect(updated_field).to be_a(described_class)
          expect(updated_field.raw_attributes).to include("id")
          expect(updated_field.raw_attributes).to include("fieldLabel")
          expect(updated_field.raw_attributes["fieldLabel"]).to eq("Gender")
          expect(updated_field.field_label).to eq("Gender")
        end
      end
    end

    describe "#delete" do
      it "deletes a field" do
        VCR.use_cassette("fields/delete") do
          mailbluster_client = Mailbluster::Client.new

          deleted_response = mailbluster_client.fields.delete(1653)

          expect(deleted_response).to eq(1653)
        end
      end
    end
  end
end
