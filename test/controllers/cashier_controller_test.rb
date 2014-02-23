require "test_helper"

class CashierControllerTest < ActionController::TestCase
  before do
    stub_payment
    session.clear
    @consumer = consumers(:one)
    @consumer.confirm!
    sign_in @consumer
    create(:salon)
    cart_add create(:product), 1
  end

  test "should index to complete" do
    get :index
    assert_redirected_to cashier_sample_url
    get :sample
    assert_response :success
    post :sample_create, { order: { samples: [Product.sample.first.id] } }
    assert_redirected_to cashier_shipment_url
    get :shipment
    assert_response :success
    post :shipment_create, { order: { salon_name: 'My Salon', shipment_attributes: attributes_for(:shipment) } }
    assert_redirected_to cashier_payment_url
    get :payment
    assert_response :success
    post :payment_create, { order: { payment_type: 'Payment::Creditcard', payment_attributes: attributes_for(:payment_creditcard) } }
    assert_redirected_to cashier_confirm_url
    get :confirm
    assert_response :success
    post :confirm_create, { order: { note: 'Note' } }
    assert_response :success
  end
end
