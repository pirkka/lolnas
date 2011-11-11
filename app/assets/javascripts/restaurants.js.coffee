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

class LunchMap
  constructor: (@locator) ->
  create: ->
    console.log google.maps
    console.log google.maps.LatLng
    latlng = new google.maps.LatLng(@locator.latitude(), @locator.longitude())
    myOptions = 
      zoom: 16,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    map = new google.maps.Map(window.document.getElementById("map_canvas"), myOptions)
    populationOptions =
      strokeColor: "#FF0000",
      strokeOpacity: 0,
      strokeWeight: 2,
      fillColor: "#FF0000",
      fillOpacity: 0.35,
      map: map,
      center: latlng,
      radius: 40
    youAreHere = new google.maps.Circle(populationOptions)

window.gl = new GeoLocator(0,0)
window.ls = new LunchSorter(gl)
window.lm = new LunchMap(gl)