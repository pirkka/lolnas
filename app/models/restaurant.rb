class Restaurant < ActiveRecord::Base

  acts_as_api

  api_accessible :default do |template|
    template.add :id
    template.add :name
    template.add :latitude
    template.add :longitude
    template.add :lunches
  end

  api_accessible :valid_lunches_only, :extend => :default do |template|
    template.add :valid_lunches, :as => :lunches, :template => :without_valid_dates
  end

  validates :name, :presence => true, :uniqueness => true
  validates :longitude, :numericality => { :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180 }
  validates :latitude, :numericality => { :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90 }

  has_many :lunches

  def valid_lunches
    lunches.valid_only
  end

end
