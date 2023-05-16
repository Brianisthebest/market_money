class Api::V0::VendorsController < ApplicationController
  def show
    vendor = Vendor.find_by_id(params[:id])

    if vendor.nil?
      render json: {
        "errors": [
         { 
           "detail": "Couldn't find Vendor with 'id'=#{params[:id]}" 
         }]
       },
       status: 404
    else
      render json: VendorSerializer.new(vendor)
    end
  end
end