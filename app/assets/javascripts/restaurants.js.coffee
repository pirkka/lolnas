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

class LunchAddress
  constructor: (@locator) ->
    @geocoder = new google.maps.Geocoder()
  display: ->
    console.log 'Showing address using reverse geocoding'
    latlng = new google.maps.LatLng(@locator.latitude(), @locator.longitude());
    @geocoder.geocode({'latLng': latlng}, (results, status) =>
      if status == google.maps.GeocoderStatus.OK
        console.log 'geocoder success'
        if results[0]
          txt = 'Lounaslista osoitteelle ' + this.formatAddress(results[0])
          this.writeAddress(txt)
        else
          console.log "No results found"
          txt = 'Lounaslista sijainnille ' + @locator.latitude() + ',' + @locator.longitude()
          this.writeAddress(txt)
      else
        console.log "Geocoder failed due to: " + status
        txt = 'Lounaslista osoitteelle Vuorikatu 15, Helsinki'
        this.writeAddress(txt)
    )
  writeAddress: (txt) ->
    $('span#address').html(txt)
  formatAddress: (result) ->
    return result.address_components[1].short_name + ' ' + result.address_components[0].short_name + ' (' + result.address_components[2].short_name + ')'

class LunchMapGUI
  constructor: (lat, lon) ->
    @gl = new GeoLocator(lat, lon)
    @ls = new LunchSorter(@gl)
    #@lm = new LunchMap(@gl)
    @la = new LunchAddress(@gl)
    #@lm.create()
    @la.display()
  locate: ->
    @gl.locate()
    #@lm.create() # creates map
    @la.display()

window.LunchMapGUI = LunchMapGUI
