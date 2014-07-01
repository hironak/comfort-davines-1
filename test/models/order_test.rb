require "test_helper"

class OrderTest < ActiveSupport::TestCase
  before do
    @order = build(:order)
    @cart = Cart.new
    @product = create(:product)
    @cart.items << CartItem.new(product: @product, amount: 10)
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

  test "margins" do
    agency = create :agency, backmargin_agency: 30, backmargin_salon: 30
    salon = create :salon, agency: agency

    @order.extend_items @cart
    @order.salon = salon
    @order.save

    @order.reload

    agency.salons.must_include salon

    @order.salon.must_equal salon
    @order.agency.must_equal agency

    @order.items.first.backmargin_salon.must_equal nil
    @order.items.first.order.agency.must_equal agency

    @order.backmargin(:agency).must_equal (@product.view_price.to_f * 30.0 / 100).to_i * 10
    @order.backmargin(:salon).must_equal (@product.view_price.to_f * 30.0 / 100).to_i * 10
  end
end
