require "test_helper"

class Administration::SolutionsControllerTest < ActionController::TestCase

  before do
    login_user create(:administrator)
    @solution = create(:solution)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:solutions)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Solution.count') do
      post :create, solution: attributes_for(:solution)
    end

    assert_redirected_to admin_solution_path(assigns(:solution))
  end

  def test_show
    get :show, id: @solution
    assert_response :success
  end

  def test_edit
    get :edit, id: @solution
    assert_response :success
  end

  def test_update
    put :update, id: @solution, solution: attributes_for(:solution)
    assert_redirected_to admin_solution_path(assigns(:solution))
  end

  def test_destroy
    assert_difference('Solution.count', -1) do
      delete :destroy, id: @solution
    end

    assert_redirected_to admin_solutions_path
  end
end
