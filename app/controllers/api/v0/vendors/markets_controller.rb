class Api::V0::Vendors::MarketsController < ApplicationController
  before_action :set_vendor

  def index
    render json: MarketSerializer.new(@vendor.markets)
  end

private
  def set_vendor
    @vendor = Vendor.find_by_id(params[:vendor_id])
  end
end