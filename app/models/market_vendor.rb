class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validates_uniqueness_of :market_id, :scope => [:vendor_id]
  validates_uniqueness_of :vendor_id, :scope => [:market_id]
end