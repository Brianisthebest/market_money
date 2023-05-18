require 'rails_helper'

RSpec.describe Market, type: :model do
  describe 'relationships' do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:county) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }
  end

  describe 'instance methods' do
    before(:each) do
      @market_1 = create(:market)
      @market_2 = create(:market)

      @vendors = []
      5.times do
        @vendors << create(:vendor, credit_accepted: true)
      end

      create(:market_vendor, market_id: @market_1.id, vendor_id: @vendors[0].id)
      create(:market_vendor, market_id: @market_1.id, vendor_id: @vendors[1].id)
      create(:market_vendor, market_id: @market_1.id, vendor_id: @vendors[2].id)
      
      create(:market_vendor, market_id: @market_2.id, vendor_id: @vendors[3].id)
      create(:market_vendor, market_id: @market_2.id, vendor_id: @vendors[4].id)
    end

    describe '#vendor_count' do
      it 'returns the number of vendors at a market' do
        expect(@market_1.vendor_count).to eq(3)
        expect(@market_2.vendor_count).to eq(2)
      end
    end

    describe '#get_vendors' do
      it 'returns all vendors for a market' do
        expect(@market_1.get_vendors).to eq([@vendors[0], @vendors[1], @vendors[2]])
        expect(@market_2.get_vendors).to eq([@vendors[3], @vendors[4]])
      end
    end

    describe '#self.search_for_markets' do
      it 'returns all markets that match the search criteria' do
        market = create(:market, name: 'Test Market', state: 'CO', city: 'Denver')

        expect(Market.search_for_markets(market.state, market.city, market.name)).to eq([market])        
      end
    end
  end
end