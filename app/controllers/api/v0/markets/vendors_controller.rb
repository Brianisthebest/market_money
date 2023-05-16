class Api::V0::Markets::VendorsController < ApplicationController
  before_action :set_market
  def index
    require 'pry'; binding.pry
  end

  private
  def set_market
    @market = Market.find(params[:market_id])
  end
end