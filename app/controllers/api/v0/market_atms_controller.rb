class Api::V0::MarketAtmsController < ApplicationController
  before_action :set_market, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, with: :error_response

  def error_response(error)
    render json: ErrorSerializer.new(error).serialize_missing_market_json, status: 404
  end

  def index
    atms = AtmFacade.new.nearby_atms(@market.lat, @market.lon)
    render json: AtmSerializer.new(atms)
  end

  private
  def set_market
    @market = Market.find(params[:id])
  end
end