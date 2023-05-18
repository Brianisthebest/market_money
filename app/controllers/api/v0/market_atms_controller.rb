class Api::V0::MarketAtmsController < ApplicationController
  def index
    market = Market.find_by_id(params[:id])
    atms = AtmFacade.new.nearby_atms(market.lat, market.lon)
    render json: AtmSerializer.new(atms)
  end
end