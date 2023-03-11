require "spec_helper"

RSpec.describe Mailbluster::Resource do
  context "with resource_type = leads" do
    describe "#create" do
      it "creates a lead" do
        VCR.use_cassette("leads/create") do
          mailbluster_client = Mailbluster::Client.new

          create_lead_attributes = {
            "firstName" => "Richard",
            "lastName" => "Hendricks",
            "fields" => {
              "gender" => "Male",
              "address" => "Silicon Valley"
            },
            "email" => "richard@example.com",
            "ipAddress" => "162.213.1.246",
            "subscribed" => false,
            "doubleOptIn" => true,
            "meta" => {
              "company" => "Pied Piper",
              "role" => "CEO"
            },
            "tags" => [
              "iPhone User",
              "Startup"
            ],
            "overrideExisting" => true
          }

          created_lead = mailbluster_client.leads.create(
            create_lead_attributes
          )

          expect(created_lead).to be_a(described_class)
          expect(created_lead.raw_attributes).to include("id")
          expect(created_lead.raw_attributes).to include("firstName")
          expect(created_lead.raw_attributes["firstName"]).to eq("Richard")
          expect(created_lead.first_name).to eq("Richard")
        end
      end
    end

    describe "#read" do
      it "reads a lead" do
        VCR.use_cassette("leads/read") do
          mailbluster_client = Mailbluster::Client.new

          found_lead = mailbluster_client.leads.read("richard@example.com")

          expect(found_lead).to be_a(described_class)
          expect(found_lead.raw_attributes).to include("id")
          expect(found_lead.raw_attributes).to include("firstName")
          expect(found_lead.raw_attributes["firstName"]).to eq("Richard")
          expect(found_lead.first_name).to eq("Richard")
        end
      end

      it "raises an error if the lead is not found" do
        VCR.use_cassette("leads/read_not_found") do
          mailbluster_client = Mailbluster::Client.new

          expect do
            mailbluster_client.leads.read("not_richard@example.com")
          end.to raise_error(Mailbluster::Client::NotFound)
        end
      end
    end

    describe "#update" do
      it "updates a lead" do
        VCR.use_cassette("leads/update") do
          mailbluster_client = Mailbluster::Client.new

          updated_lead = mailbluster_client.resource("leads").update(
            "richard@example.com",
            {
              "fields" => {
                "gender" => "Male",
                "address" => nil,
                "hobby" => "Programming"
              },
              "subscribed" => true,
              "meta" => {
                "company" => "Piper Net"
              },
              "addTags" => [
                "Entrepreneur"
              ],
              "removeTags" => [
                "iPhone User"
              ]
            }
          )
          expect(updated_lead).to be_a(described_class)
          expect(updated_lead.raw_attributes).to include("id")
          expect(updated_lead.raw_attributes).to include("firstName")
          expect(updated_lead.raw_attributes["firstName"]).to eq("Richard")
          expect(updated_lead.first_name).to eq("Richard")
          expect(updated_lead.tags.sort).to eq(["Entrepreneur", "Startup"].sort)
        end
      end

      it "raises an UnprocessableEntity error if the attributes are invalid" do
        VCR.use_cassette("leads/update_unprocessable_entity") do
          mailbluster_client = Mailbluster::Client.new

          expect do
            mailbluster_client.leads.update(
              "richard@example.com",
              { email: "invalidemail" }
            )
          end.to raise_error(Mailbluster::Client::UnprocessableEntity).with_message(
            '{"email":"Email address is invalid"}'
          )
        end
      end
    end

    describe "#delete" do
      it "deletes a lead" do
        VCR.use_cassette("leads/delete") do
          mailbluster_client = Mailbluster::Client.new

          deleted_response = mailbluster_client.leads.delete("richard@example.com")

          expect(deleted_response).to eq("5a91f0b2d2c1e5c3229d906d978b7337")
        end
      end
    end
  end
end
