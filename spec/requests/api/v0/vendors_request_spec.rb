require 'rails_helper'

RSpec.describe 'Vendors API' do
  describe 'GET /api/v0/vendors/:id' do
    it 'returns a specific vendor' do
      vendor = create(:vendor)

      get "/api/v0/vendors/#{vendor.id}"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to be_an(String)
      expect(json[:data][:id]).to eq(vendor.id.to_s)

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('vendor')

      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)

      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes][:name]).to be_a(String)
      expect(json[:data][:attributes][:name]).to eq(vendor.name)

      expect(json[:data][:attributes]).to have_key(:description)
      expect(json[:data][:attributes][:description]).to be_a(String)
      expect(json[:data][:attributes][:description]).to eq(vendor.description)
      
      expect(json[:data][:attributes]).to have_key(:contact_name)
      expect(json[:data][:attributes][:contact_name]).to be_a(String)
      expect(json[:data][:attributes][:contact_name]).to eq(vendor.contact_name)
      
      expect(json[:data][:attributes]).to have_key(:contact_phone)
      expect(json[:data][:attributes][:contact_phone]).to be_a(String)
      expect(json[:data][:attributes][:contact_phone]).to eq(vendor.contact_phone)

      expect(json[:data][:attributes]).to have_key(:credit_accepted)
      expect(json[:data][:attributes][:credit_accepted]).to be_in([true, false])
      expect(json[:data][:attributes][:credit_accepted]).to eq(vendor.credit_accepted)
    end

    it 'returns a 404 if the vendor is not found' do
      get '/api/v0/vendors/1'

      expect(response.status).to eq(404)
    end
  end
end