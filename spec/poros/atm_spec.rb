require 'rails_helper'

RSpec.describe Atm do
  describe 'atm' do
    it 'exists and has attributes' do
      data = {
        poi: { name: 'ATM' },
        address: { freeformAddress: '123 AMT St' },
        position: { lat: 39.750783, lon: -104.996435 },
        dist: 0.1,
        id: nil
      }

      atm = Atm.new(data)

      expect(atm).to be_a(Atm)
      expect(atm.name).to eq(data[:poi][:name])
      expect(atm.address).to eq(data[:address][:freeformAddress])
      expect(atm.lat).to eq(data[:position][:lat])
      expect(atm.lon).to eq(data[:position][:lon])
      expect(atm.distance).to eq(data[:dist])
    end
  end
end