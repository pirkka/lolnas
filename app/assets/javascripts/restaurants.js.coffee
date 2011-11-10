# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class GeoLocator
  constructor: (@lat, @lon) ->
  setCoordinates: (position) ->
    @lat = position.coords.latitude
    @lon = position.coords.longitude
    console.log 'Set location to ' + @lat + ',' + @lon
  locationFailed: ->
    alert 'Failed to geololcate (o __ o)¨'
  locate: (callback, callback_e) ->
    if window.navigator.geolocation
      console.log 'Locating'
      window.navigator.geolocation.getCurrentPosition((position) => 
        this.setCoordinates(position)
      , this.locationFailed);
    else
      alert 'Geololcation is not supported. :/'
  latitude: ->
    return @lat
  longitude: ->
    return @lon

class LunchSorter
  constructor: (@locator) ->
  sortByCloseness: ->
    lat = @locator.latitude()
    lon = @locator.longitude()
    console.log 'Sorting lunches for ' + lat + ',' + lon
    
    return 'done'

window.gl = new GeoLocator(0,0)
window.ls = new LunchSorter(gl)
