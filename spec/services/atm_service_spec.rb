require 'rails_helper'

RSpec.describe AtmService do
  describe 'nearby_atms' do
    it 'returns a hash of nearby atms' do
      atm_service = AtmService.new

      expect(atm_service.nearby_atms(39.750783, -104.996435)).to be_a(Hash)
    end
  end
end