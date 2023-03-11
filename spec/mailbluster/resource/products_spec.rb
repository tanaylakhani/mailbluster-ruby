require "spec_helper"

RSpec.describe Mailbluster::Resource do
  context "with resource_type = products" do
    describe "#create" do
      it "creates a product" do
        VCR.use_cassette("products/create") do
          mailbluster_client = Mailbluster::Client.new

          create_product_attributes = {
            "id" => "101",
            "name" => "Reign Html Template"
          }

          created_product = mailbluster_client.products.create(
            create_product_attributes
          )

          expect(created_product).to be_a(described_class)
          expect(created_product.raw_attributes).to include("id")
          expect(created_product.raw_attributes).to include("name")
          expect(created_product.raw_attributes["name"]).to eq("Reign Html Template")
          expect(created_product.name).to eq("Reign Html Template")
        end
      end
    end

    describe "#read" do
      it "reads a product" do
        VCR.use_cassette("products/read") do
          mailbluster_client = Mailbluster::Client.new

          found_product = mailbluster_client.products.read(101)

          expect(found_product).to be_a(described_class)
          expect(found_product.raw_attributes).to include("id")
          expect(found_product.raw_attributes).to include("name")
          expect(found_product.raw_attributes["name"]).to eq("Reign Html Template")
          expect(found_product.name).to eq("Reign Html Template")
        end
      end

      it "reads all products" do
        VCR.use_cassette("products/read_page_no_1") do
          mailbluster_client = Mailbluster::Client.new

          found_products = mailbluster_client.products.read(page_no: 1)
          expect(found_products).to be_a(Array)
          expect(found_products.size).to eq(1)
          found_product = found_products.first

          expect(found_product).to be_a(described_class)
          expect(found_product.raw_attributes).to include("id")
          expect(found_product.raw_attributes).to include("name")
          expect(found_product.raw_attributes["name"]).to eq("Reign Html Template")
          expect(found_product.name).to eq("Reign Html Template")
        end
      end
    end

    describe "#update" do
      it "updates a product" do
        VCR.use_cassette("products/update") do
          mailbluster_client = Mailbluster::Client.new

          updated_product = mailbluster_client.resource("products").update(
            101,
            {
              "name" => "Reign PRO Html Template"
            }
          )
          expect(updated_product).to be_a(described_class)
          expect(updated_product.raw_attributes).to include("id")
          expect(updated_product.raw_attributes).to include("name")
          expect(updated_product.raw_attributes["name"]).to eq("Reign PRO Html Template")
          expect(updated_product.name).to eq("Reign PRO Html Template")
        end
      end
    end

    describe "#delete" do
      it "deletes a product" do
        VCR.use_cassette("products/delete") do
          mailbluster_client = Mailbluster::Client.new

          deleted_response = mailbluster_client.products.delete(101)

          expect(deleted_response).to eq(101)
        end
      end
    end
  end
end
