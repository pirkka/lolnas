class Lunch < ActiveRecord::Base

  acts_as_api

  api_accessible :default do |template|
    template.add :id
    template.add :price
    template.add :title
  end

  belongs_to :restaurant

  scope :by_restaurant_id, lambda { |restaurant_id| where('(? IS NULL OR restaurant_id = ?)', restaurant_id, restaurant_id)}

end
