require 'test_helper'

class SortListsControllerTest < ActionController::TestCase
  setup do
    @sort_list = sort_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sort_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sort_list" do
    assert_difference('SortList.count') do
      post :create, sort_list: { description: @sort_list.description, no: @sort_list.no }
    end

    assert_redirected_to sort_list_path(assigns(:sort_list))
  end

  test "should show sort_list" do
    get :show, id: @sort_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sort_list
    assert_response :success
  end

  test "should update sort_list" do
    put :update, id: @sort_list, sort_list: { description: @sort_list.description, no: @sort_list.no }
    assert_redirected_to sort_list_path(assigns(:sort_list))
  end

  test "should destroy sort_list" do
    assert_difference('SortList.count', -1) do
      delete :destroy, id: @sort_list
    end

    assert_redirected_to sort_lists_path
  end
end
