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
require 'pry'; binding.pry
      json[:data].each do |atm|
        expect(atm[:type]).to eq("atm")
        expect(atm[:attributes]).to have_key(:name)
        expect(atm[:attributes]).to have_key(:address)
        expect(atm[:attributes]).to have_key(:lat)
        expect(atm[:attributes]).to have_key(:lon)
        expect(atm[:attributes]).to have_key(:distance)
      end
    end

    it 'returns a 404 error when a market is not found' do
      get "/api/v0/markets/200/nearest_atms"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:errors)
      expect(json[:errors][0][:detail]).to eq("Couldn\'t find Market with \'id\'=200")
    end
  end
end