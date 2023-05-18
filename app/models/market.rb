class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  validates_presence_of :name, :street, :city, :county, :state, :zip, :lat, :lon

  def vendor_count
    self.vendors.count
  end

  def get_vendors
    self.vendors
  end

  def self.search_for_markets(state, city, name)
    Market.where("name ILIKE ? and city ILIKE ? and state ILIKE ?", "%#{name}%", "%#{city}%", "%#{state}%")
  end
end