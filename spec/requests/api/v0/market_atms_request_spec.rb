require 'rails_helper'

RSpec.describe 'Market ATMs API' do
  describe 'GET /api/v0/markets/:id/nearest_atms' do
    it 'returns a list of nearby ATMs' do
      market = create(:market, lat: 39.750783, lon: -104.996435)

      get "/api/v0/markets/#{market.id}/nearest_atms"

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to be_an(Array)
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq("atm")
      expect(json[:data][:attributes]).to have_key(:name)
      expect(json[:data][:attributes]).to have_key(:address)
      expect(json[:data][:attributes]).to have_key(:lat)
      expect(json[:data][:attributes]).to have_key(:lon)
      expect(json[:data][:attributes]).to have_key(:distance)
    end
  end
end