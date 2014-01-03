require "test_helper"

class Administration::FileStoragesControllerTest < ActionController::TestCase

  before do
    login_user administrators(:one)
    @file_storage = create(:file_storage)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:file_storages)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('FileStorage.count') do
      post :create, file_storage: { name: 'New Name', path: '/test/test/test'  }
    end

    assert_redirected_to admin_file_storage_path(assigns(:file_storage))
  end

  def test_show
    get :show, id: @file_storage
    assert_response :success
  end

  def test_edit
    get :edit, id: @file_storage
    assert_response :success
  end

  def test_update
    put :update, id: @file_storage, file_storage: { name: 'Edit Name', path: 'test/test/test'  }
    assert_redirected_to admin_file_storage_path(assigns(:file_storage))
  end

  def test_destroy
    assert_difference('FileStorage.count', -1) do
      delete :destroy, id: @file_storage
    end

    assert_redirected_to admin_file_storages_path
  end
end
