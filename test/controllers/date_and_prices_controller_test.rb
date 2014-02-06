require 'test_helper'

class DateAndPricesControllerTest < ActionController::TestCase
  setup do
    @date_and_price = date_and_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:date_and_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create date_and_price" do
    assert_difference('DateAndPrice.count') do
      post :create, date_and_price: { departure_date: @date_and_price.departure_date, export: @date_and_price.export, retail_price: @date_and_price.retail_price, return_date: @date_and_price.return_date, ticket_issuing_date: @date_and_price.ticket_issuing_date, tour_id: @date_and_price.tour_id, trade_price: @date_and_price.trade_price, visa_mailing_date: @date_and_price.visa_mailing_date }
    end

    assert_redirected_to date_and_price_path(assigns(:date_and_price))
  end

  test "should show date_and_price" do
    get :show, id: @date_and_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @date_and_price
    assert_response :success
  end

  test "should update date_and_price" do
    patch :update, id: @date_and_price, date_and_price: { departure_date: @date_and_price.departure_date, export: @date_and_price.export, retail_price: @date_and_price.retail_price, return_date: @date_and_price.return_date, ticket_issuing_date: @date_and_price.ticket_issuing_date, tour_id: @date_and_price.tour_id, trade_price: @date_and_price.trade_price, visa_mailing_date: @date_and_price.visa_mailing_date }
    assert_redirected_to date_and_price_path(assigns(:date_and_price))
  end

  test "should destroy date_and_price" do
    assert_difference('DateAndPrice.count', -1) do
      delete :destroy, id: @date_and_price
    end

    assert_redirected_to date_and_prices_path
  end
end
