class Api::V0::MarketAtmsController < ApplicationController
  def index
    market = Market.find_by_id(params[:id])

    if market.nil?
      render json: {
        "errors": [
         { 
           status: "404",
           detail: "Couldn't find Market with 'id'=#{params[:id]}" 
         }]
       },
       status: 404
    else
      atms = AtmFacade.new.nearby_atms(market.lat, market.lon)
      render json: AtmSerializer.new(atms)
    end
  end
end