class Restaurant < ActiveRecord::Base

  acts_as_api

  api_accessible :default do |template|
    template.add :id
    template.add :name
    template.add :url
    template.add :latitude
    template.add :longitude
    template.add :lunches
    template.add :distance # NB
  end

  api_accessible :valid_lunches_only, :extend => :default do |template|
    template.add :valid_lunches, :as => :lunches, :template => :without_valid_dates
  end

  validates :name, :presence => true, :uniqueness => true
  validates :longitude, :numericality => { :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180 }
  validates :latitude, :numericality => { :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90 }

  has_many :lunches

  belongs_to :user, :class_name => "Api::User"

  def valid_lunches
    lunches.valid_only
  end

  def distance=(value)
    @distance = value
  end

  def distance
    @distance
  end

  # as long as our db doesn't support this...
  def self.sort_by_distance(restaurants, lat, lon)
    Rails.logger.debug("sorting for #{lat}, #{lon}")
    restaurants.each do |r|
      r.distance = Restaurant.distance_formula(r.latitude.to_f, lat.to_f, r.longitude.to_f, lon.to_f)
      Rails.logger.debug("#{r.name} at #{r.latitude}, #{r.longitude} ---> #{r.distance}")
    end
    restaurants.sort { |a,b| a.distance <=> b.distance }
  end

  # upgrade when needed to true lat lon formula
  def self.distance_formula (x1, x2, y1, y2) # define method distance formula with parameters x1, x2, y1, y2
    d = Math.sqrt(((x2 - x1) ** 2) + ((y2 - y1) ** 2)) # distance = square root of x2-x1^2 + y2-y1^2
    return d # return d, the distance
  end

end
