require 'spec_helper'

describe Restaurant do
  before(:each) do
    @arthur = Factory.create(:restaurant, :name => "Arthur")
  end

  it "shows valid Arthur lunches" do
    @arthur_lunch1 = Factory.create(:lunch,
                                    :restaurant => @arthur,
                                    :title => "Hiililohi",
                                    :price => 10.70,
                                    :valid_from => Time.now.beginning_of_day,
                                    :valid_until => Time.now.end_of_day)
    @arthur_lunch2 = Factory.create(:lunch,
                                    :restaurant => @arthur,
                                    :title => "Sitruunakalaa",
                                    :price => 10.70,
                                    :valid_from => Time.now.beginning_of_day + 1.day,
                                    :valid_until => Time.now.end_of_day + 1.day)

    @arthur.valid_lunches.should include(@arthur_lunch1)
    @arthur.valid_lunches.should_not include(@arthur_lunch2)
  end

end