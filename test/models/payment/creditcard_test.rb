require "test_helper"

class Payment::CreditcardTest < ActiveSupport::TestCase
  def test_success_charge_create
    stub_request(:post, "https://api.webpay.jp/v1/charges")
      .to_return(:status => 200, :body => success_charge_create_body, :headers => {})
    payment = Payment::Creditcard.new
    payment.attributes = attributes_for(:payment_creditcard)
    payment.charge_create
    assert_equal payment.webpay_id, "ch_fp83Bi1RsdR1afC"
  end

  def test_error_charge_create
    stub_request(:post, "https://api.webpay.jp/v1/charges")
      .to_return(:status => 402, :body => error_charge_create_body, :headers => {})
    payment = Payment::Creditcard.new
    payment.attributes = attributes_for(:payment_creditcard)
    assert_raise WebPay::CardError do
      payment.charge_create
    end
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

  def error_charge_create_body
    <<-JSON
      {
        "error": {
          "code": "incorrect_number",
          "message": "Your card number is incorrect",
          "param": "number",
          "type": "card_error"
        }
      }
    JSON
  end
end
