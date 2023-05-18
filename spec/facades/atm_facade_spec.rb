require 'rails_helper'

RSpec.describe AtmFacade do
  describe 'exists' do
    it 'exists' do
      atm_facade = AtmFacade.new
      
      expect(atm_facade).to be_a(AtmFacade)
    end
  end

  describe 'nearby_atms' do
    it 'returns a list of atm objects' do
      atm_facade = AtmFacade.new

      expect(atm_facade.nearby_atms(39.750783, -104.996435)).to be_a(Array)
      expect(atm_facade.nearby_atms(39.750783, -104.996435)).to all(be_a(Atm))
    end
  end
end