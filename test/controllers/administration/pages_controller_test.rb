require "test_helper"

class Administration::PagesControllerTest < ActionController::TestCase
  before do
    stub_validator
    login_user administrators(:one)
    @page = create(:page)
  end

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

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Page.count') do
      post :create, page: { body: 'New body', style: ".validstyle {\n}" }
    end

    assert_redirected_to admin_page_path(assigns(:page))
  end

  def test_show
    get :show, id: @page
    assert_response :success
  end

  def test_edit
    get :edit, id: @page
    assert_response :success
  end

  def test_update
    put :update, id: @page, page: { body: 'Edit body', style: ".validstyle {\n}"  }
    assert_redirected_to admin_page_path(assigns(:page))
  end

  def test_destroy
    assert_difference('Page.count', -1) do
      delete :destroy, id: @page
    end

    assert_redirected_to admin_pages_path
  end
end
