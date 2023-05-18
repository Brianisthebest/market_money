require 'rails_helper'

RSpec.describe Atm do
  describe 'atm' do
    it 'exists and has attributes' do
      data = {
              name: "ATM",
              address: "123 AMT St",
              lat: 39.750783,
              lon: -104.996435,
              distance: 0.1
      }

      atm = Atm.new(data)

      expect(atm).to be_a(Atm)
      expect(atm.name).to eq(data[:name])
      expect(atm.address).to eq(data[:address])
      expect(atm.lat).to eq(data[:lat])
      expect(atm.lon).to eq(data[:lon])
      expect(atm.distance).to eq(data[:distance])
    end
  end
end