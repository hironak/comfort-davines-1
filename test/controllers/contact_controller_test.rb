require "test_helper"

class ContactControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, contact: { type: '商品について', name: 'name', name_kana: 'kana', email: 'test@example.com', phone: '000-0000-0000', body: 'body' }
    assert_response :success
  end
end
