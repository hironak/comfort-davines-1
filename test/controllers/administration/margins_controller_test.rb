require "test_helper"

class Administration::MarginsControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
    @agency = create :agency do |agency|
      agency.create_administrator(attributes_for(:administrator))
    end
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:agencies)
  end

  def test_show
    get :show, id: @agency
    assert_response :success
  end

  def test_edit
    get :edit, id: @agency
    assert_response :success
  end

  def test_update
    put :update, id: @agency, agency: { product_margins_attributes: []  }
    assert_redirected_to admin_margin_path(assigns(:agency))
  end
end
