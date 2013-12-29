require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "avaiable scope not include sample" do
    assert_equal Product.avaiable.count, 2
  end

  test "sample scope include sample" do
    assert_equal Product.samples.count, 1
  end
end
