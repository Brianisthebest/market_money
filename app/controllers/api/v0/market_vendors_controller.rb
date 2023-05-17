class Api::V0::MarketVendorsController < ApplicationController
  def create
    market_vendor = MarketVendor.new(market_vendor_params)

    if market_vendor.save
      render json: MarketVendorSerializer.new(market_vendor), status: 201
    elsif market_vendor.errors.attribute_names.include?(:market) || market_vendor.errors.attribute_names.include?(:vendor)
      render json: {
        "errors": [
          {
            "detail": "Validation failed: #{market_vendor.errors.full_messages.to_sentence}"
          }]
      },
      status: 404
    else
      render json: {
        "errors": [
          {
            "detail": "Validation failed: Market vendor asociation between market with market_id=#{params[:market_vendor][:market_id]} and vendor_id=#{params[:market_vendor][:vendor_id]} already exists"
          }]
      },
      status: 422
    end
  end

  def destroy
    market = Market.find_by_id(params[:market_vendor][:market_id])
    vendor = Vendor.find_by_id(params[:market_vendor][:vendor_id])
    
    market_vendor = MarketVendor.find_market_vendor(market, vendor)

    market_vendor.destroy_all
  end

  private
  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end