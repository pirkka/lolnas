require 'spec_helper'

describe Lunch do

  before(:each) do
    @arthur = Factory.create(:restaurant, :name => "Arthur")
  end

  it "parses valid date field correctly" do
    @arthur_lunch = Factory.create(:lunch,
                                   :restaurant => @arthur,
                                   :title => "Hiililohi",
                                   :price => 10.70,
                                   :valid_date => "1.1.1970")

    @arthur_lunch.valid_from.should == Time.utc(1970,1,1).beginning_of_day
    @arthur_lunch.valid_until.should == Time.utc(1970,1,1).end_of_day
  end

end