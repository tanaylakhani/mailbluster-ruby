require "spec_helper"

RSpec.describe Mailbluster do
  describe " =>:VERSION" do
    it "is a string" do
      expect(Mailbluster::VERSION).not_to be nil
      expect(Mailbluster::VERSION).to be_a(String)
    end
  end
end
