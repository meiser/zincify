require 'test_helper'

class CommissionsControllerTest < ActionController::TestCase
  setup do
    @commission = commissions(:three)
    session[:user_id] = @commission.id
  end

  test "redirect_to_new_session_path" do
      session[:user_id] = nil
      get :index, :format => "mobile"
      assert_redirected_to(:controller => :sessions, :action => :new)
      assert_response :redirect
      assert flash[:notice]
  end

  test "should get index" do
    get :index, :format => "mobile"
    assert_response :success
    assert_not_nil assigns(:commissions)
  end

  test "should get new" do
    get :new, :format => "mobile"
    assert_response :success
  end

  test "should create commission" do
    assert_difference('Commission.count') do
      post :create, commission: { appointment: @commission.appointment, orno: @commission.orno, reference: @commission.reference }, :format => "mobile"
    end

    #assert_redirected_to commission_path(assigns(:commission))
    assert_redirected_to commissions_path
    assert flash[:notice]
  end


  test "should show commission" do
    get :show, id: @commission, :format => "mobile"
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @commission, :format => "mobile"
    assert_response :success
  end

  test "should update commission" do
    put :update, id: @commission, commission: { appointment: @commission.appointment, orno: @commission.orno, reference: @commission.reference }, :format => "mobile"
    assert_redirected_to commission_path(assigns(:commission))
  end

  test "should destroy commission" do
    assert_difference('Commission.count', -1) do
      delete :destroy, id: @commission, :format => "mobile"
    end

    assert_redirected_to commissions_path
  end

end

