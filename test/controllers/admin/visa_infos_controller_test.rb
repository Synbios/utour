require 'test_helper'

class Admin::VisaInfosControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get upadte" do
    get :upadte
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
