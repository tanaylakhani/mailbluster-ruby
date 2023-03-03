require "test_helper"

class MailblusterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Mailbluster::VERSION
  end
end
