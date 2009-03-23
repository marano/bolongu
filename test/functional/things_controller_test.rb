require 'test_helper'

class ThingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:things)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thing" do
    assert_difference('Thing.count') do
      post :create, :thing => { }
    end

    assert_redirected_to thing_path(assigns(:thing))
  end

  test "should show thing" do
    get :show, :id => things(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => things(:one).to_param
    assert_response :success
  end

  test "should update thing" do
    put :update, :id => things(:one).to_param, :thing => { }
    assert_redirected_to thing_path(assigns(:thing))
  end

  test "should destroy thing" do
    assert_difference('Thing.count', -1) do
      delete :destroy, :id => things(:one).to_param
    end

    assert_redirected_to things_path
  end
end
