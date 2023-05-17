class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validates_uniqueness_of :market_id, :scope => [:vendor_id]
  validates_uniqueness_of :vendor_id, :scope => [:market_id]

  def self.find_market_vendor(market, vendor)
    where(market_id: market.id, vendor_id: vendor.id)
  end
end