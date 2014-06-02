require "test_helper"

class Consumer::InformationTest < ActiveSupport::TestCase

  test "normalize phone" do
    information = Consumer::Information.new
    information.phone = "０９０−４１６６ー０７４０"
    information.valid?

    information.phone.must_equal "090-4166-0740"
  end
end
