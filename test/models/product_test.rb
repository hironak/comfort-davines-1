require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "available scope not include sample" do
    assert_equal Product.available.count, 2
  end

  test "sample scope include sample" do
    assert_equal Product.sample.count, 1
  end
end
