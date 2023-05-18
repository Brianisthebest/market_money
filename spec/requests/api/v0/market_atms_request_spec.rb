require 'rails_helper'

RSpec.describe 'Market ATMs API' do
  describe 'GET /api/v0/markets/:id/nearest_atms' do
    it 'returns a list of nearby ATMs' do
      market = create(:market, lat: 39.750783, lon: -104.996435)

      get "/api/v0/markets/#{market.id}/nearest_atms"

      
    end
  end
end