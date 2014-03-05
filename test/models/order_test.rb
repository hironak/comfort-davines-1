require "test_helper"

class OrderTest < ActiveSupport::TestCase
  before do
    @order = build(:order)
    @cart = Cart.new
    @cart.items << CartItem.new(product: create(:product))
    @cart.save
  end

  test "xxxx_ready?" do
    @order.extend_items @cart
    @order.initialize_ready?.must_equal true

    sample = create(:product, sample: true)
    @order.sample_selected = true
    @order.sample_ids = [sample.id]
    @order.sample_ready?.must_equal true

    @order.attributes = {
      salon_prefecture: '北海道',
      salon_name: 'A',
      salon_not_found: true,
      shipment_attributes: attributes_for(:shipment) }
    @order.shipment_ready?.must_equal true

    stub_payment
    @order.attributes = {
      payment_type: 'Payment::Creditcard',
      payment_attributes: attributes_for(:payment_creditcard) }
    @order.payment_ready?.must_equal true
  end
end
