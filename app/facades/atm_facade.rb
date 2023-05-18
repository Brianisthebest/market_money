class AtmFacade
  def nearby_atms(lat, lon)
    results = service.nearby_atms(lat, lon)
    
    results[:results].map do |result|
      Atm.new(result)
    end
  end

private
  def service
    @service ||= AtmService.new
  end
end