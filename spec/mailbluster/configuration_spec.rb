require "spec_helper"

RSpec.describe Mailbluster::Configuration do
  describe "#configuration" do
    it "is not nil" do
      expect(Mailbluster.configuration).not_to be nil
      expect(Mailbluster.configuration).to be_a(described_class)
      Mailbluster.configure do |config|
        expect(config).to be_a(described_class)
      end
    end

    describe "#api_url" do
      it "is not nil" do
        expect(Mailbluster.configuration.api_url).
          to eq("https://api.mailbluster.com/api/")
      end
    end
  end
end
