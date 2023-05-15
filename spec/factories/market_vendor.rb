FactoryBot.define do
  factory marke_vendor do
    market_id { Faker::Number.between(from:1, to: 10) }
    vendor_id { Faker::Number.between(from:1, to: 10) }
  end
end