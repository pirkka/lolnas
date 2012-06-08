class Numeric
  def to_rad
    self * Math::PI / 180
  end
end

class Restaurant < ActiveRecord::Base

  acts_as_api

  api_accessible :default do |template|
    template.add :id
    template.add :name
    template.add :url
    template.add :latitude
    template.add :longitude
    template.add :lunches
    template.add :distance_from_current_position, :as => :distance # NB
    template.add :data_provider_title
    template.add :data_provider_url
  end

  api_accessible :valid_lunches_only, :extend => :default do |template|
    template.add :valid_lunches, :as => :lunches, :template => :without_valid_dates
  end

  validates :name, :presence => true, :uniqueness => true
  validates :longitude, :numericality => { :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180 }
  validates :latitude, :numericality => { :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90 }

  has_many :lunches

  belongs_to :api_user, :class_name => "Api::User"

  attr_accessible :name, :url, :latitude, :longitude, :distance, :data_provider_title, :data_provider_url, :api_user_id

  def valid_lunches
    lunches.valid_only
  end

  def distance_from_current_position
    distance_from_position(Location.coordinates)
  end

  def distance_from_position(coordinates)
    latitude, longitude = coordinates
    @distance = Restaurant.distance_formula([self.latitude, self.longitude],
                                           [latitude.to_f, longitude.to_f])
  end

  # as long as our db doesn't support this...
  def self.sort_by_distance(restaurants, coordinates)
    Rails.logger.debug("sorting for #{coordinates}")
    restaurants.sort { |a,b| a.distance_from_position(coordinates) <=>
                              b.distance_from_position(coordinates) }
  end

  # http://www.movable-type.co.uk/scripts/latlong.html
  # loc1 and loc2 are arrays of [latitude, longitude]
  def self.distance_formula loc1, loc2
     lat1, lon1 = loc1
     lat2, lon2 = loc2
     dLat = (lat2-lat1).to_rad
     dLon = (lon2-lon1).to_rad
     a = Math.sin(dLat/2) * Math.sin(dLat/2) +
         Math.cos(lat1.to_rad) * Math.cos(lat2.to_rad) *
         Math.sin(dLon/2) * Math.sin(dLon/2)
     c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
     d = 6371 * c * 1000 # Multiply by 6371 to get Kilometers --> and further by 1000 to get meters I_I
     return d
  end


end
