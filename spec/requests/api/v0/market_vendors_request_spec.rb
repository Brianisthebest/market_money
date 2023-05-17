require 'rails_helper'

RSpec.describe 'Market Vendors API' do
  describe 'POST /api/v0/market_vendors' do
    it 'can create a market vendor' do
      market_1 = create(:market)
      vendor_1 = create(:vendor)
      vendor_2 = create(:vendor)
      market_vendor_params = ({ "market_id": market_1.id, "vendor_id": vendor_1.id })

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vender: market_vendor_params)
    
      expect(response).to be_successful
    end
  end
end