require "test_helper"

class Administration::AgenciesControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
    @agency = create(:agency)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:agencies)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Agency.count') do
      post :create, agency_params
    end

    assert_redirected_to admin_agency_path(assigns(:agency))
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
    put :update, { id: @agency }.merge(agency_params)
    assert_redirected_to admin_agency_path(assigns(:agency))
  end

  def test_destroy
    assert_difference('Agency.count', -1) do
      delete :destroy, id: @agency
    end

    assert_redirected_to admin_agencies_path
  end

  def agency_params
    {
      agency: {
        name: 'My Agency',
        administrator_attributes: {
          username: 'testuser1',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    }
  end

end
