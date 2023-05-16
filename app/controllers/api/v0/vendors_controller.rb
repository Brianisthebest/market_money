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

  def create
    vendor = Vendor.new(vendor_params)

    if vendor.save
      render json: VendorSerializer.new(vendor), status: 201
    else
      render json: {
        "errors": [
         { 
           "detail": "Validations failed: #{vendor.errors.full_messages.to_sentence}" 
         }]
       },
       status: 400
    end
  end

  private
  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end