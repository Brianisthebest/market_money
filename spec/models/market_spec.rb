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
    describe '#vendor_count' do
      it 'returns the number of vendors at a market' do
        market_1 = create(:market)
        market_2 = create(:market)
        vendors = create_list(:vendor, 5)
  
        create(:market_vendor, market_id: market_1.id, vendor_id: vendors[0].id)
        create(:market_vendor, market_id: market_1.id, vendor_id: vendors[1].id)
        create(:market_vendor, market_id: market_1.id, vendor_id: vendors[2].id)
        
        create(:market_vendor, market_id: market_2.id, vendor_id: vendors[3].id)
        create(:market_vendor, market_id: market_2.id, vendor_id: vendors[4].id)

        expect(market_1.vendor_count).to eq(3)
        expect(market_2.vendor_count).to eq(2)
      end
    end
  end
end