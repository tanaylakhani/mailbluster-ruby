require "spec_helper"

RSpec.describe Mailbluster::Client do
  it "raises an error if API KEY is incorrect" do
    VCR.use_cassette("client/forbidden") do
      mailbluster_client = described_class.new("incorrect")

      expect do
        mailbluster_client.leads.read("not_richard@example.com")
      end.to raise_error(Mailbluster::Client::Forbidden)
    end
  end
end
