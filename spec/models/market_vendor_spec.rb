require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe 'relationships' do
    it { should belong_to(:market) }
    it { should belong_to(:vendor) }
  end

  describe 'validations' do
    before(:each) do
      market = create(:market)
      vendor = create(:vendor)
      create(:market_vendor, market_id: market.id, vendor_id: vendor.id)
    end
      it { is_expected.to validate_uniqueness_of(:market_id).scoped_to(:vendor_id) }
      it { is_expected.to validate_uniqueness_of(:vendor_id).scoped_to(:market_id) }
  end

  describe 'class methods' do
    describe '.find_market_vendor' do
      it 'returns a market_vendor object associated to the market and vendor' do
        market_1 = create(:market)
        market_2 = create(:market)
        vendor_1 = create(:vendor)
        market_vendor = create(:market_vendor, market_id: market_1.id, vendor_id: vendor_1.id)
        market_vendor_2 = create(:market_vendor, market_id: market_2.id, vendor_id: vendor_1.id)

        expect(MarketVendor.find_market_vendor(market_1, vendor_1)).to eq([market_vendor])
        expect(MarketVendor.find_market_vendor(market_2, vendor_1)).to eq([market_vendor_2])
      end
    end
  end
end