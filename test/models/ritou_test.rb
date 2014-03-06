require "test_helper"

class RitouTest < ActiveSupport::TestCase
  before do
    create :ritou, postalcode: "0431400"
  end

  test "include? true" do
    assert_equal Ritou.include?("043-1400"), true
  end

  test "include? false" do
    assert_equal Ritou.include?("242-0001"), false
  end
end
