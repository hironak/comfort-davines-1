require "test_helper"

class CashierControllerTest < ActionController::TestCase
  before do
    stub_request(:post, "https://api.webpay.jp/v1/charges")
      .to_return(:status => 200, :body => success_charge_create_body, :headers => {})
    stub_request(:get, "https://api.webpay.jp/v1/charges/ch_fp83Bi1RsdR1afC")
      .to_return(:status => 200, :body => charge_response, :headers => {})
    stub_request(:post, "https://api.webpay.jp/v1/charges/ch_fp83Bi1RsdR1afC/capture")
      .to_return(:status => 200, :body => charge_response, :headers => {})
    create(:salon)
    sign_in consumers(:one)
    cart_add create(:product), 1
  end

  test "should get index" do
    get :index
    assert_redirected_to cashier_sample_url
  end

  test "should get sample" do
    get :index
    get :sample
    assert_response :success
  end

  test "should post sample" do
    get :index
    get :sample
    post :sample_create, { order: { sample: Product.sample.first.id } }
    assert_redirected_to cashier_shipment_url
  end

  test "should get shipment" do
    get :index
    get :shipment
    assert_response :success
  end

  test "should post shipment" do
    get :index
    get :shipment
    post :shipment_create, { order: { salon_name: 'My Salon', shipment_attributes: attributes_for(:shipment) } }
    assert_redirected_to cashier_payment_url
  end

  test "should get payment" do
    get :index
    get :shipment
    post :shipment_create, { order: { salon_name: 'My Salon', shipment_attributes: attributes_for(:shipment) } }
    get :payment
    assert_response :success
  end

  test "should post payment" do
    get :index
    get :shipment
    post :shipment_create, { order: { salon_name: 'My Salon', shipment_attributes: attributes_for(:shipment) } }
    get :payment
    post :payment_create, { order: { payment_type: 'Payment::Creditcard', payment_attributes: attributes_for(:payment_creditcard) } }
    assert_redirected_to cashier_confirm_url
  end

  test "should get confirm" do
    get :index
    get :shipment
    post :shipment_create, { order: { salon_name: 'My Salon', shipment_attributes: attributes_for(:shipment) } }
    get :payment
    post :payment_create, { order: { payment_type: 'Payment::Creditcard', payment_attributes: attributes_for(:payment_creditcard) } }
    get :confirm
    assert_response :success
  end

  test "should post confirm" do
    get :index
    get :shipment
    post :shipment_create, { order: { salon_name: 'My Salon', shipment_attributes: attributes_for(:shipment) } }
    get :payment
    post :payment_create, { order: { payment_type: 'Payment::Creditcard', payment_attributes: attributes_for(:payment_creditcard) } }
    get :confirm
    post :confirm_create, { order: { note: 'Note' } }
    assert_redirected_to cashier_complete_url
  end

  test "should get complete" do
    get :index
    get :shipment
    post :shipment_create, { order: { salon_name: 'My Salon', shipment_attributes: attributes_for(:shipment) } }
    get :payment
    post :payment_create, { order: { payment_type: 'Payment::Creditcard', payment_attributes: attributes_for(:payment_creditcard) } }
    get :confirm
    post :confirm_create, { order: { note: 'Note' } }
    get :complete
    assert_response :success
  end

  def success_charge_create_body
    <<-JSON
      {
        "id": "ch_fp83Bi1RsdR1afC",
        "object": "charge",
        "livemode": false,
        "currency": "jpy",
        "description": null,
        "amount": 400,
        "amount_refunded": 0,
        "customer": null,
        "created": 1390875702,
        "paid": true,
        "refunded": false,
        "failure_message": null,
        "card": {
          "object": "card",
          "exp_year": 2014,
          "exp_month": 11,
          "fingerprint": "215b5b2fe460809b8bb90bae6eeac0e0e0987bd7",
          "name": "KEI KUBO",
          "country": "JP",
          "type": "Visa",
          "cvc_check": "pass",
          "last4": "4242"
        },
        "captured": false,
        "expire_time": null
      }
    JSON
  end

  def charge_response
    <<-JSON
      {
        "id": "ch_fp83Bi1RsdR1afC",
        "object": "charge",
        "livemode": false,
        "currency": "jpy",
        "description": null,
        "amount": 400,
        "amount_refunded": 0,
        "customer": null,
        "created": 1390875702,
        "paid": true,
        "refunded": false,
        "failure_message": null,
        "card": {
          "object": "card",
          "exp_year": 2014,
          "exp_month": 11,
          "fingerprint": "215b5b2fe460809b8bb90bae6eeac0e0e0987bd7",
          "name": "KEI KUBO",
          "country": "JP",
          "type": "Visa",
          "cvc_check": "pass",
          "last4": "4242"
        },
        "captured": true,
        "expire_time": null
      }
    JSON
  end
end
