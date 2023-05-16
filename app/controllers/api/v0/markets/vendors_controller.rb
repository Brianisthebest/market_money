class Api::V0::Markets::VendorsController < ApplicationController
  before_action :set_market
  
  def index
    if @market.nil?
      render json: {
                     "errors": [
                      { 
                        "detail": "Couldn't find Market with 'id'=#{params[:id]}" 
                      }]
                    },
                    status: 404
    else
      render json: VendorSerializer.new(@market.get_vendors)
    end
  end

  private
  def set_market
    @market = Market.find_by_id(params[:market_id])
  end
end