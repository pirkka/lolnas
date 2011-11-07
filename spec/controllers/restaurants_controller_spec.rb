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

      response.body.should include("<h2>Raiku</h2>")
    end

    it "show Happiness' thai-buffet" do
      get "index"

      response.body.should include("<h2>Happiness</h2>\nThai-buffet\n<strong>8.5</strong>")
    end

  end

end