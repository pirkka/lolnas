class Lunch < ActiveRecord::Base

  acts_as_api

  api_accessible :default do |template|
    template.add :id
    template.add :price
    template.add :title
    template.add :valid_from
    template.add :valid_until
  end

  api_accessible :without_valid_dates, :extend => :default do |template|
    template.remove :valid_from
    template.remove :valid_until
  end

  belongs_to :restaurant

  scope :valid_only, lambda { where('(valid_from IS NULL AND valid_until IS NULL) OR (valid_from < ? AND valid_until > ?)', Time.now, Time.now) }
  scope :by_restaurant_id, lambda { |restaurant_id| where('(? IS NULL OR restaurant_id = ?)', restaurant_id, restaurant_id) }

  def valid_date=(valid_date)
    parsed_date = Date.parse(valid_date)
    self.valid_from = parsed_date.beginning_of_day
    self.valid_until = parsed_date.end_of_day
  end

end
