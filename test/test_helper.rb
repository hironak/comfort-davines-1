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

  DatabaseCleaner.strategy = :truncation

  before :each do
    DatabaseCleaner.start
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
end
