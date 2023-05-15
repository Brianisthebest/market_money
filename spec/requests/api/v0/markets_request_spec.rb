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
      market_2 = create(:market)
      vendors = create_list(:vendor, 5)

      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[0].id)
      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[1].id)
      create(:market_vendor, market_id: market_1.id, vendor_id: vendors[2].id)
      
      create(:market_vendor, market_id: market_2.id, vendor_id: vendors[3].id)
      create(:market_vendor, market_id: market_2.id, vendor_id: vendors[4].id)
      
      get '/api/v0/markets'

      markets = JSON.parse(response.body, symbolize_names: true)

      expect(markets[:data][0][:attributes][:vendor_count]).to eq(3)
      expect(market_1.vendors.count).to eq(3)
      
      expect(markets[:data][1][:attributes][:vendor_count]).to eq(2)
      expect(market_2.vendors.count).to eq(2)
      end
    end
  end
end