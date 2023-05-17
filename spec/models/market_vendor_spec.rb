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
end