require 'spec_helper'

describe WelcomeController do
  render_views

  describe "GET index" do
    it "shows logo" do
      get "index"

      response.body.should include("lolnas.svg")
    end
  end

end