require 'test_helper'

class TraversesControllerTest < ActionController::TestCase
  setup do
    @traverse = traverses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:traverses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create traverse" do
    assert_difference('Traverse.count') do
      post :create, traverse: { name: @traverse.name, remarks: @traverse.remarks }
    end

    assert_redirected_to traverse_path(assigns(:traverse))
  end

  test "should show traverse" do
    get :show, id: @traverse
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @traverse
    assert_response :success
  end

  test "should update traverse" do
    put :update, id: @traverse, traverse: { name: @traverse.name, remarks: @traverse.remarks }
    assert_redirected_to traverse_path(assigns(:traverse))
  end

  test "should destroy traverse" do
    assert_difference('Traverse.count', -1) do
      delete :destroy, id: @traverse
    end

    assert_redirected_to traverses_path
  end
end
