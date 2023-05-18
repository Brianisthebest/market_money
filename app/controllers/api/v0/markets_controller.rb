class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
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
      render json: MarketSerializer.new(Market.find(params[:id]))
    end
  end

  def search
    markets = Market.search_for_markets(params[:state], params[:city], params[:name])
    
    render json: MarketSerializer.new(markets)
  end
end