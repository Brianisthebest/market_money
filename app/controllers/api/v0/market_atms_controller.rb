class Api::V0::MarketAtmsController < ApplicationController
  def index
    market = Market.find_by_id(params[:id])
    atms = AtmFacade.new(market.lat, market.lon).nearby_atms
    require 'pry'; binding.pry
  end
end