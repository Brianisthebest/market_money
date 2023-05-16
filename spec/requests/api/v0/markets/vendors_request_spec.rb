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
      
    end
  end
end