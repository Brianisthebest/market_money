class Api::V0::VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :error_response

  def error_response(error)
    render json: ErrorSerializer.new(error).serialize_missing_market_json, status: 404
  end

  def show
    render json: VendorSerializer.new(@vendor)
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

  def update
    if @vendor.update(vendor_params)
      render json: VendorSerializer.new(@vendor)
    else
      render json: {
        "errors": [
         { 
           "detail": "Validations failed: #{@vendor.errors.full_messages.to_sentence}" 
           }]
         },
      status: 400
    end
  end

  def destroy
    @vendor.destroy
  end

  private
  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  def set_vendor
    @vendor = Vendor.find(params[:id])
  end
end