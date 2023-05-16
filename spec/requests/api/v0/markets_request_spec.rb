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
        expect(market[:attributes][:name]).to be_a(String)

        expect(market[:attributes]).to have_key(:street)
        expect(market[:attributes][:street]).to be_a(String)

        expect(market[:attributes]).to have_key(:city)
        expect(market[:attributes][:city]).to be_a(String)

        expect(market[:attributes]).to have_key(:county)
        expect(market[:attributes][:county]).to be_a(String)

        expect(market[:attributes]).to have_key(:state)
        expect(market[:attributes][:state]).to be_a(String)

        expect(market[:attributes]).to have_key(:zip)
        expect(market[:attributes][:zip]).to be_a(String)

        expect(market[:attributes]).to have_key(:lat)
        expect(market[:attributes][:lat]).to be_a(String)

        expect(market[:attributes]).to have_key(:lon)
        expect(market[:attributes][:lon]).to be_a(String)
        end
      end

    it 'returns a new attribute called vendor_count' do
      market_1 = create(:market)
      vendors = create_list(:vendor, 5)

      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[0].id)
      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[1].id)
      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[2].id)
      
      get '/api/v0/markets'

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data][0][:attributes]).to have_key(:vendor_count)
      expect(markets[:data][0][:attributes][:vendor_count]).to be_an(Integer)
    end
  end

  describe 'GET /api/v0/markets/:id' do
    it 'returns a single market' do
      market = create(:market, name: 'Farmers Market',
                               street: '123 Main St',
                               city: 'Colo Springs',
                               county: 'El Paso',
                               state: 'CO',
                               zip: '80123',
                               lat: '39',
                               lon: '40')

      get "/api/v0/markets/#{market.id}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to eq(market.id.to_s)
      expect(json[:data][:attributes][:name]).to eq(market.name)
      expect(json[:data][:attributes][:street]).to eq(market.street)
      expect(json[:data][:attributes][:city]).to eq(market.city)
      expect(json[:data][:attributes][:county]).to eq(market.county)
      expect(json[:data][:attributes][:state]).to eq(market.state)
      expect(json[:data][:attributes][:zip]).to eq(market.zip)
      expect(json[:data][:attributes][:lat]).to eq(market.lat)
      expect(json[:data][:attributes][:lon]).to eq(market.lon)
    end

    it 'sad path: returns 404 if market does not exist' do
      get '/api/v0/markets/1'

      expect(response.status).to eq(404)
    end
  end
end