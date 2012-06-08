module Location

  def self.last_known_or_default_location(location_as_json)
    if location_as_json
      last_known_location = JSON.parse(location_as_json)

      return last_known_location["latitude"],
             last_known_location["longitude"]
    end

    # defaults
    return 60.172389, 24.947516
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