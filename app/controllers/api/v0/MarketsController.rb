class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    # require 'pry'; binding.pry
    market = Market.find_by_id(params[:id])
    if market.nil?
      render json: { code: 404,
                     status: "Not Found",
                     "errors": [{ 
                     "detail": "Couldn't find Market with 'id'=#{params[:id]}" }]
                    }
    else
      render json: MarketSerializer.new(Market.find(params[:id]))
    end
  end
end