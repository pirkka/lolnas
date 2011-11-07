class Lunch < ActiveRecord::Base

  acts_as_api

  api_accessible :default do |template|
    template.add :id
    template.add :price
    template.add :title
  end

  belongs_to :restaurant

  scope :valid_only, where('(valid_from IS NULL AND valid_until IS NULL) OR (valid_from > ? AND valid_until < ?)', Time.now, Time.now)

  def self.by_restaurant_id(restaurant_id)
    where('(? IS NULL OR restaurant_id = ?)', restaurant_id, restaurant_id)
  end

end
