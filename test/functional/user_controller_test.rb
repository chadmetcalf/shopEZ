require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get admin_login" do
    get :admin_login
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
