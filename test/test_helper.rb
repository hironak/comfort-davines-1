require "simplecov"
SimpleCov.start 'rails'

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "webmock/minitest"
require 'database_cleaner'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActionController::TestCase
  include Devise::TestHelpers
  include Sorcery::TestHelpers::Rails
end


class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  DatabaseCleaner.strategy = :transaction

  before :each do
    DatabaseCleaner.start
    stub_payment
  end

  after :each do
    DatabaseCleaner.clean
  end

  # Add more helper methods to be used by all tests here...

  def current_cart
    @controller.send(:current_cart)
  end

  def cart_add product, amount
    current_cart.add product, amount
  end

  def cart_remove product, amount
    current_cart.remove product, amount
  end

  # Validator Stub
  def stub_validator
    stub_request(:get, W3CValidators::CSSValidator::CSS_VALIDATOR_URI)
      .with(query: hash_including(request_params))
      .to_return(:status => 200, :body => "", :headers => {})
  end

  def request_params
    {
      output: 'soap12',
      profile: 'css3',
    }
  end

  # WebPay stub
  def stub_payment
    stub_request(:post, "https://api.webpay.jp/v1/charges")
      .to_return(:status => 200, :body => success_charge_create_body, :headers => {})
    stub_request(:get, "https://api.webpay.jp/v1/charges/ch_fp83Bi1RsdR1afC")
      .to_return(:status => 200, :body => charge_response, :headers => {})
    stub_request(:post, "https://api.webpay.jp/v1/charges/ch_fp83Bi1RsdR1afC/capture")
      .to_return(:status => 200, :body => charge_response, :headers => {})
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
