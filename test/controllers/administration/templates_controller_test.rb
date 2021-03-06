require "test_helper"

class Administration::TemplatesControllerTest < ActionController::TestCase

  before do
    stub_validator
    login_user create(:administrator)
    @template = create(:template)
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
    assert_difference('Template.count') do
      post :create, template: attributes_for(:template)
    end

    assert_redirected_to admin_template_path(assigns(:template))
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
    put :update, id: @template, template: attributes_for(:template)
    assert_redirected_to admin_template_path(assigns(:template))
  end

  def test_destroy
    assert_difference('Template.count', -1) do
      delete :destroy, id: @template
    end

    assert_redirected_to admin_templates_path
  end
end
