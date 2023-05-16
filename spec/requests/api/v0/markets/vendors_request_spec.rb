require 'rails_helper'

RSpec.describe 'Markets Vendors API' do
  describe 'GET /api/v0/markets/:id/vendors' do
    it 'returns the vendors associated with that market' do
      market_1 = create(:market)
      market_2 = create(:market)

      vendors = create_list(:vendor, 5)

      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[0].id)
      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[1].id)
      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[2].id)
      create(:market_vendor, market_id: market_2.id, vendor_id: vendors[3].id)
      create(:market_vendor, market_id: market_2.id, vendor_id: vendors[4].id)

      get "/api/v0/markets/#{market_1.id}/vendors"

      expect(response).to be_successful
      
      json = JSON.parse(response.body, symbolize_names: true)

      json[:data].each do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor[:id]).to be_an(String)

        expect(vendor).to have_key(:type)
        expect(vendor[:type]).to eq("vendor")

        expect(vendor).to have_key(:attributes)
        expect(vendor[:attributes]).to be_a(Hash)

        expect(vendor[:attributes]).to have_key(:name)
        expect(vendor[:attributes][:name]).to be_a(String)
        
        expect(vendor[:attributes]).to have_key(:description)
        expect(vendor[:attributes][:description]).to be_a(String)
        
        expect(vendor[:attributes]).to have_key(:contact_name)
        expect(vendor[:attributes][:contact_name]).to be_a(String)
        
        expect(vendor[:attributes]).to have_key(:contact_phone)
        expect(vendor[:attributes][:contact_phone]).to be_a(String)
        
        expect(vendor[:attributes]).to have_key(:credit_accepted)
        expect(vendor[:attributes][:credit_accepted]).to be_in([true, false])
      end
    end
    
    it 'sad path: returns 404 if market does not exist' do
      get '/api/v0/markets/1/vendors'

      expect(response.status).to eq(404)
    end
  end
end