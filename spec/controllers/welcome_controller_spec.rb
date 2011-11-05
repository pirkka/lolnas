require 'spec_helper'

describe WelcomeController do
  render_views

  describe "GET index" do
    it "shows logo" do
      get "index"

      response.body.should include("logo_lolnas.gif")
    end
  end

end