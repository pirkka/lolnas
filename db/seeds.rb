# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

User.create!(:email => "quentin@example.com", :password => "monkey")

h = Restaurant.create!(:name => 'Happiness', :latitude => 60.17176616743565, :longitude => 24.947290420532227)
r = Restaurant.create!(:name => 'Raiku', :latitude => 60.180335531616585, :longitude => 24.951839447021484)

Lunch.create!(:restaurant_id => h.id, :title => 'Thai buffet (sushilla)', :price => 9.50)
Lunch.create!(:restaurant_id => h.id, :title => 'Thai buffet (ilman sushia)', :price => 8.50)
Lunch.create!(:restaurant_id => r.id, :title => 'Buffet: lihapullat, salaatti, parsakeitto', :price => 9.20)