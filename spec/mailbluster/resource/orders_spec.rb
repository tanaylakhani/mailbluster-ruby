require "spec_helper"

RSpec.describe Mailbluster::Resource do
  context "with resource_type = orders" do
    describe "#create" do
      it "creates a order" do
        VCR.use_cassette("orders/create") do
          mailbluster_client = Mailbluster::Client.new

          create_order_attributes = {
            "id" => "order_id_0001",
            "customer" => {
              "firstName" => "Richard",
              "lastName" => "Hendricks",
              "fields" => {
                "gender" => "Male",
                "address" => "Silicon Valley"
              },
              "email" => "richard@example.com",
              "subscribed" => true
            },
            "currency" => "USD",
            "totalPrice" => 10.43,
            "campaignId" => 174_486,
            "items" => [
              {
                "id" => "101",
                "name" => "Reign Html Template",
                "price" => 2.13,
                "quantity" => 1
              },
              {
                "id" => "102",
                "name" => "Slick Html Template",
                "price" => 4.15,
                "quantity" => 2
              }
            ]
          }

          created_order = mailbluster_client.orders.create(
            create_order_attributes
          )

          expect(created_order).to be_a(described_class)
          expect(created_order.raw_attributes).to include("id")
          expect(created_order.raw_attributes).to include("totalPrice")
          expect(created_order.raw_attributes["totalPrice"]).to eq("10.43")
          expect(created_order.total_price).to eq("10.43")
        end
      end
    end

    describe "#read" do
      it "reads a order" do
        VCR.use_cassette("orders/read") do
          mailbluster_client = Mailbluster::Client.new

          found_order = mailbluster_client.orders.read("order_id_0001")

          expect(found_order).to be_a(described_class)
          expect(found_order.raw_attributes).to include("id")
          expect(found_order.raw_attributes).to include("totalPrice")
          expect(found_order.raw_attributes["totalPrice"]).to eq("10.43")
          expect(found_order.total_price).to eq("10.43")
        end
      end

      it "reads all orders" do
        VCR.use_cassette("orders/read_page_no_1") do
          mailbluster_client = Mailbluster::Client.new

          found_orders = mailbluster_client.orders.read(page_no: 1)
          expect(found_orders).to be_a(Array)
          expect(found_orders.size).to eq(1)
          found_order = found_orders.first

          expect(found_order).to be_a(described_class)
          expect(found_order.raw_attributes).to include("id")
          expect(found_order.raw_attributes).to include("totalPrice")
          expect(found_order.raw_attributes["totalPrice"]).to eq("10.43")
          expect(found_order.total_price).to eq("10.43")
        end
      end
    end

    describe "#update" do
      it "updates a order" do
        VCR.use_cassette("orders/update") do
          mailbluster_client = Mailbluster::Client.new

          updated_order = mailbluster_client.resource("orders").update(
            "order_id_0001",
            {
              "customer" => {
                "fields" => {
                  "gender" => "Male",
                  "address" => "Silicon Valley"
                },
                "subscribed" => false,
                "meta" => {
                  "gender" => "Male"
                },
                "tags" => [
                  "Developer"
                ]
              },
              "campaignId" => 174_486,
              "currency" => "USD",
              "totalPrice" => 17.28,
              "items" => [
                {
                  "id" => "103",
                  "name" => "Falcon Html Template",
                  "price" => 4.49,
                  "quantity" => 2
                },
                {
                  "id" => "102",
                  "name" => "Slick Html Template",
                  "price" => 4.15,
                  "quantity" => 2
                }
              ]
            }
          )
          expect(updated_order).to be_a(described_class)
          expect(updated_order.raw_attributes).to include("id")
          expect(updated_order.raw_attributes).to include("totalPrice")
          expect(updated_order.raw_attributes["totalPrice"]).to eq("17.28")
          expect(updated_order.total_price).to eq("17.28")
        end
      end
    end

    describe "#delete" do
      it "deletes a order" do
        VCR.use_cassette("orders/delete") do
          mailbluster_client = Mailbluster::Client.new

          deleted_response = mailbluster_client.orders.delete("order_id_0001")

          expect(deleted_response).to eq("order_id_0001")
        end
      end
    end
  end
end
