require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:first)
    session[:user_id] = users(:first)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end

