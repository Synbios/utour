require 'test_helper'

class WechatWebsControllerTest < ActionController::TestCase
  test "should get tiger" do
    get :tiger
    assert_response :success
  end

end
