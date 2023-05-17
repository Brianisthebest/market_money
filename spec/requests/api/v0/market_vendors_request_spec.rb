require 'rails_helper'

RSpec.describe 'Market Vendors API' do
  describe 'POST /api/v0/market_vendors' do
    it 'can create a market vendor' do
      market_1 = create(:market, name: "Test Market")
      vendor_1 = create(:vendor)

      market_vendor_params = ({ "market_id": market_1.id, "vendor_id": vendor_1.id })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
      
      created_market_vendor = MarketVendor.last

      expect(created_market_vendor.market_id).to eq(market_1.id)
      expect(created_market_vendor.vendor_id).to eq(vendor_1.id)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      get "/api/v0/vendors/#{vendor_1.id}/markets"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][0]).to have_key(:id)
      expect(json[:data][0][:id]).to eq(market_1.id.to_s)
      expect(json[:data][0][:attributes][:name]).to eq(market_1.name)
      expect(json[:data][0][:attributes][:street]).to eq(market_1.street)
      expect(json[:data][0][:attributes][:city]).to eq(market_1.city)
      expect(json[:data][0][:attributes][:county]).to eq(market_1.county)
      expect(json[:data][0][:attributes][:state]).to eq(market_1.state)
      expect(json[:data][0][:attributes][:zip]).to eq(market_1.zip)
      expect(json[:data][0][:attributes][:lat]).to eq(market_1.lat)
      expect(json[:data][0][:attributes][:lon]).to eq(market_1.lon)
      expect(json[:data][0][:attributes][:vendor_count]).to eq(market_1.vendor_count)
    end

    it 'returns a 404 if market does not exist' do
      vendor_1 = create(:vendor)

      market_vendor_params = ({ "market_id": 1, "vendor_id": vendor_1.id })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:errors)
      expect(json[:errors][0][:detail]).to eq("Validation failed: Market must exist")
    end

    it 'returns a 404 if vendor does not exist' do
      market_1 = create(:market)

      market_vendor_params = ({ "market_id": market_1.id, "vendor_id": 1 })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:errors)
      expect(json[:errors][0][:detail]).to eq("Validation failed: Vendor must exist")
    end

    it 'returns a 422 if the relationship between the market and vendor already exists' do
      market = create(:market)
      vendor = create(:vendor)
      create(:market_vendor, market_id: market.id, vendor_id: vendor.id)

      market_vendor_params = ({ "market_id": market.id, "vendor_id": vendor.id })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
    
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors][0][:detail]).to eq("Validation failed: Market vendor asociation between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists")
    end
  end

  describe 'DELETE /api/v0/market_vendors' do
    it 'deletes the relationship between a market and vendor' do
      market_1 = create(:market)
      market_2 = create(:market)
      vendor = create(:vendor)

      market_vendor = create(:market_vendor, market_id: market_1.id, vendor_id: vendor.id)
      create(:market_vendor, market_id: market_2.id, vendor_id: vendor.id)

      market_vendor_params = ({ "market_id": market_1.id, "vendor_id": vendor.id })

      headers = {"CONTENT_TYPE" => "application/json"}

      delete "/api/v0/market_vendors/", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

      expect(response).to be_successful
      expect(response.status).to eq(204)
      expect(MarketVendor.find_by_id(market_vendor.id)).to be(nil)

      get "/api/v0/vendors/#{vendor.id}/markets"

      json = JSON.parse(response.body, symbolize_names: true)

      json[:data].each do |market|
        expect(market[:id]).to eq(market_2.id.to_s)
        expect(market[:id]).to_not eq(market_1.id.to_s)
      end
    end

    it 'returns a 404 if market does not exist' do
      market_vendor_params = ({ "market_id": 10, "vendor_id": 10 })

      headers = {"CONTENT_TYPE" => "application/json"}

      delete "/api/v0/market_vendors/", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors][0][:detail]).to eq("No MarketVendor with market_id=10 AND vendor_id=10 exists")
    end
  end
end