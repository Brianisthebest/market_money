FactoryBot.define do
  factory :market_vendor do
    association :market, :factory => :market
    association :vendor, :factory => :vendor
  end
end