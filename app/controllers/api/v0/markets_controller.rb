class Api::V0::MarketsController < ApplicationController
  before_action :validate_params, only: [:search]
  rescue_from ActiveRecord::RecordNotFound, with: :error_response

  def error_response(error)
    render json: ErrorSerializer.new(error).serialize_missing_market_json, status: 404
  end

  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    market = Market.find(params[:id])
    render json: MarketSerializer.new(market)
  end

  def search
    markets = Market.search_for_markets(params[:state], params[:city], params[:name])
    render json: MarketSerializer.new(markets)
  end

  def validate_params
    if just_a_city || just_city_and_name
      render_error_message
    end
  end

  def just_a_city
    params[:city].present? && !params[:state].present? && !params[:name].present? 
  end

  def just_city_and_name
    params[:city].present? && params[:name].present? && !params[:state].present?
  end

  def render_error_message
    render json: {
      "errors": [
       { 
         status: "422",
         detail: "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint." 
       }]
     },
     status: 422
  end
end