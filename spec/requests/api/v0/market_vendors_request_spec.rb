require 'rails_helper'

RSpec.describe 'Market Vendors API' do
  describe 'POST /api/v0/market_vendors' do
    it 'can create a market vendor' do
      market_1 = create(:market, name: "Test Market")
      vendor_1 = create(:vendor)
      vendor_2 = create(:vendor)
      market_vendor_params = ({ "market_id": market_1.id, "vendor_id": vendor_1.id })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
      
      created_market_vendor = MarketVendor.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end
end