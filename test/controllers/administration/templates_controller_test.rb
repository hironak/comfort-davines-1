require "test_helper"

class Administration::TemplatesControllerTest < ActionController::TestCase

  before do
    stub_validator
    login_user create(:administrator)
    @template = create(:product_template)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:templates)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Product::Template.count') do
      post :create, template: {  }
    end

    assert_redirected_to template_path(assigns(:template))
  end

  def test_show
    get :show, id: @template
    assert_response :success
  end

  def test_edit
    get :edit, id: @template
    assert_response :success
  end

  def test_update
    put :update, id: @template, template: {  }
    assert_redirected_to template_path(assigns(:template))
  end

  def test_destroy
    assert_difference('Product::Template.count', -1) do
      delete :destroy, id: @template
    end

    assert_redirected_to templates_path
  end
end
