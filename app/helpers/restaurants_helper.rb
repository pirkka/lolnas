# encoding: UTF-8
module RestaurantsHelper

  def format_price(price)
    return "#{format("%.2f", price).gsub(".",",")} €" if price
  end

end
