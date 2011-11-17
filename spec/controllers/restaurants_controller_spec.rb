# encoding: UTF-8
require 'spec_helper'

describe RestaurantsController do
  render_views

  describe "GET index" do
    before(:each) do
      @raiku = Factory.create(:restaurant, :name => "Raiku")
      @happiness = Factory.create(:restaurant, :name => "Happiness")

      @happiness_buffet = Factory.create(:lunch,
                                         :restaurant => @happiness,
                                         :title => "Thai-buffet",
                                         :price => 8.50)
    end

    it "shows Raiku" do
      get "index"

      response.body.should include("<div class='restaurant'>Raiku</div>")
    end

    it "show Happiness' thai-buffet" do
      get "index"

      response.body.should include("<div class='restaurant'>Happiness</div>\n<div class='menu'>\nThai-buffet\n<strong>8,50 €</strong>")
    end

  end

end