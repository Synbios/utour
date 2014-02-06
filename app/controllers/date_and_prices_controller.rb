class DateAndPricesController < ApplicationController
  before_action :set_date_and_price, only: [:show, :edit, :update, :destroy]

  # GET /date_and_prices
  # GET /date_and_prices.json
  def index
    @date_and_prices = DateAndPrice.all
  end

  # GET /date_and_prices/1
  # GET /date_and_prices/1.json
  def show
  end

  # GET /date_and_prices/new
  def new
    @date_and_price = DateAndPrice.new
  end

  # GET /date_and_prices/1/edit
  def edit
  end

  # POST /date_and_prices
  # POST /date_and_prices.json
  def create
    @date_and_price = DateAndPrice.new(date_and_price_params)

    respond_to do |format|
      if @date_and_price.save
        format.html { redirect_to @date_and_price, notice: 'Date and price was successfully created.' }
        format.json { render action: 'show', status: :created, location: @date_and_price }
      else
        format.html { render action: 'new' }
        format.json { render json: @date_and_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /date_and_prices/1
  # PATCH/PUT /date_and_prices/1.json
  def update
    respond_to do |format|
      if @date_and_price.update(date_and_price_params)
        format.html { redirect_to @date_and_price, notice: 'Date and price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @date_and_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /date_and_prices/1
  # DELETE /date_and_prices/1.json
  def destroy
    @date_and_price.destroy
    respond_to do |format|
      format.html { redirect_to date_and_prices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_and_price
      @date_and_price = DateAndPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def date_and_price_params
      params.require(:date_and_price).permit(:tour_id, :departure_date, :return_date, :visa_mailing_date, :ticket_issuing_date, :trade_price, :retail_price, :export)
    end
end
