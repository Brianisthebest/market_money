require 'rails_helper'

RSpec.describe 'Markets API' do
  describe 'GET /api/v0/markets' do
    it 'returns all markets' do
      create_list(:market, 5)

      get '/api/v0/markets'

      expect(response).to be_successful

      markets = JSON.parse(response.body, symbolize_names: true)

      markets[:data].each do |market|
        expect(market).to have_key(:id)
        expect(market[:id]).to be_an(String)
        expect(market).to have_key(:type)
        expect(market[:type]).to eq('market')
        expect(market).to have_key(:attributes)

        expect(market[:attributes]).to be_a(Hash)
        expect(market[:attributes]).to have_key(:name)
        expect(market[:attributes]).to have_key(:street)
        expect(market[:attributes]).to have_key(:city)
        expect(market[:attributes]).to have_key(:county)
        expect(market[:attributes]).to have_key(:state)
        expect(market[:attributes]).to have_key(:zip)
        expect(market[:attributes]).to have_key(:lat)
        expect(market[:attributes]).to have_key(:lon)
        end
      end

    it 'returns a new attribute called vendor_count'
  end
end