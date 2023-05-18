class AtmFacade
  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def nearby_atms
    results = service.nearby_atms(@lat, @lon)
    
    results[:results].map do |result|
      Atm.new(result)
    end
  end

private
  def service
    @service ||= AtmService.new
  end
end