class Api::V0::Markets::VendorsController < ApplicationController
  before_action :set_market
  rescue_from ActiveRecord::RecordNotFound, with: :error_response

  def error_response(error)
    render json: ErrorSerializer.new(error).serialize_missing_market_json, status: 404
  end
  
  def index
    render json: VendorSerializer.new(@market.get_vendors)
  end

  private
  def set_market
    @market = Market.find(params[:market_id])
  end
end