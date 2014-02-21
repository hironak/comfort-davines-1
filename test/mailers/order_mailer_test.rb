require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "complete" do
    @products = create_list(:product, 4)
    @samples = create_list(:product, 2, sample: true)
    @order = create(:order_with_items, consumer: @consumer, samples: @samples, products: @products)
    mail = OrderMailer.complete('to@example.org', @order)
    # assert_equal "Complete", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["order@davines.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  end

end
