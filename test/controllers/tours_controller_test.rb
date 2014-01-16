require 'test_helper'

class ToursControllerTest < ActionController::TestCase
  setup do
    @tour = tours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tour" do
    assert_difference('Tour.count') do
      post :create, tour: { content: @tour.content, departure_date: @tour.departure_date, identifier: @tour.identifier, name: @tour.name, retail_price: @tour.retail_price, return_date: @tour.return_date, ticket_issuing_date: @tour.ticket_issuing_date, trade_price: @tour.trade_price, visa_mailing_date: @tour.visa_mailing_date }
    end

    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should show tour" do
    get :show, id: @tour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tour
    assert_response :success
  end

  test "should update tour" do
    patch :update, id: @tour, tour: { content: @tour.content, departure_date: @tour.departure_date, identifier: @tour.identifier, name: @tour.name, retail_price: @tour.retail_price, return_date: @tour.return_date, ticket_issuing_date: @tour.ticket_issuing_date, trade_price: @tour.trade_price, visa_mailing_date: @tour.visa_mailing_date }
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should destroy tour" do
    assert_difference('Tour.count', -1) do
      delete :destroy, id: @tour
    end

    assert_redirected_to tours_path
  end
end
