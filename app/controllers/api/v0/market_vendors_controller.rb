class Api::V0::MarketVendorsController < ApplicationController
  def create
    market_vendor = MarketVendor.new(market_vendor_params)

    if market_vendor.save
      render json: MarketVendorSerializer.new(market_vendor), status: 201
    end
  end

  private
  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end
end