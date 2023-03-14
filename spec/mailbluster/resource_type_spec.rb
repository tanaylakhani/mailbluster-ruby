require "spec_helper"

RSpec.describe Mailbluster::ResourceType do
  it "raises an error if API KEY is incorrect" do
    mailbluster_client = Mailbluster::Client.new
    leads_resource_type = mailbluster_client.leads

    expect(leads_resource_type).to be_a(described_class)
    expect(leads_resource_type.inspect).to eq("#<Mailbluster::ResourceType::Lead>")
  end
end
