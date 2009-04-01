require 'test_helper'

class ScrapsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scraps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scrap" do
    assert_difference('Scrap.count') do
      post :create, :scrap => { }
    end

    assert_redirected_to scrap_path(assigns(:scrap))
  end

  test "should show scrap" do
    get :show, :id => scraps(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => scraps(:one).to_param
    assert_response :success
  end

  test "should update scrap" do
    put :update, :id => scraps(:one).to_param, :scrap => { }
    assert_redirected_to scrap_path(assigns(:scrap))
  end

  test "should destroy scrap" do
    assert_difference('Scrap.count', -1) do
      delete :destroy, :id => scraps(:one).to_param
    end

    assert_redirected_to scraps_path
  end
end
