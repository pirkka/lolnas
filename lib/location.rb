module Location

  def self.default_location
    # defaults
    return 60.172389, 24.947516
  end

  def self.parse_location_from_json(location_as_json)
    last_known_location = JSON.parse(location_as_json)

    return last_known_location["latitude"],
           last_known_location["longitude"]
  end

  def self.coordinates=(coordinates)
    @latitude, @longitude = coordinates
  end

  def self.latitude
    @latitude
  end

  def self.longitude
    @longitude
  end

  def self.coordinates
    return nil unless @latitude and @longitude

    return @latitude, @longitude
  end

end