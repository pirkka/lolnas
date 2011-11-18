# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class GeoLocator
  constructor: (@lat, @lon) ->
  setCoordinates: (position) ->
    @lat = position.coords.latitude
    @lon = position.coords.longitude
    console.log 'Location was set to ' + @lat + ',' + @lon
  locationFailed: ->
    alert 'Failed to geololcate (o __ o)'
  locate: (callback, callback_e) ->
    if window.navigator.geolocation
      console.log 'Locating...'
      window.navigator.geolocation.getCurrentPosition((position) =>
        this.setCoordinates(position)
        callback()
      , this.locationFailed);
    else
      alert 'Geololcation is not supported. :/'
  latitude: ->
    return @lat
  longitude: ->
    return @lon

class LunchSorter
  constructor: (@locator) ->
  htmlRestaurant: (r) ->
    html = ''
    html += '<div class="maplink">'
    html += '<a href="http://maps.google.com/maps?q=' + r.latitude + ',' + r.longitude + '+(' + r.name + ')&z=16">kartalla</a>'
    html += '</div>'
    html += '<div class="restaurant">'
    html += '<a href="' + r.url + '">'
    html += r.name
    html += '</a>'
    html += ' ' + Math.round(r.distance) + 'm'
    html += '</div>'
    html += '<div class="menu">'
    html += this.htmlLunch(l) for l in r.lunches
    html += '</div>'
    return html
  htmlLunch: (l) ->
    html = ''
    html += l.title
    html += '&nbsp;<strong>'
    html += l.price
    html += '&nbsp;&euro;</strong>'
    html += '<br />'
    return html
  sortByCloseness: ->
    lat = @locator.latitude()
    lon = @locator.longitude()
    console.log 'Sorting lunches for ' + lat + ',' + lon
    # ajax from server
    ajax_settings =
      context: this
      success: (data) =>
        # empty list
        $('#list').html('')
        # update html list
        $('#list').append(this.htmlRestaurant(d)) for d in data.restaurants

      url: '/api/restaurants.json?latitude=' + lat + '&longitude=' + lon
    $.ajax(ajax_settings)

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
    console.log 'Showing address for ' + @locator.latitude() + ',' + @locator.longitude()
    latlng = new google.maps.LatLng(@locator.latitude(), @locator.longitude());
    @geocoder.geocode({'latLng': latlng}, (results, status) =>
      if status == google.maps.GeocoderStatus.OK
        if results[0]
          txt = 'Lounaslista osoitteelle ' + this.formatAddress(results[0])
          this.writeAddress(txt)
        else
          txt = 'Lounaslista sijainnille ' + @locator.latitude() + ',' + @locator.longitude()
          this.writeAddress(txt)
      else
        console.log "Geocoder failed due to: " + status
        txt = 'Geokoodaus ep&auml;onnistui.'
        this.writeAddress(txt)
    )
  writeAddress: (txt) ->
    $('span#address').html(txt)
  formatAddress: (result) ->
    return result.address_components[1].short_name + ' ' + result.address_components[0].short_name + ' (' + result.address_components[2].short_name + ')'

class LunchMapGUI
  constructor: (lat, lon) ->
    console.log 'Initial location is ' + lat + ',' + lon
    @gl = new GeoLocator(lat, lon)
    @ls = new LunchSorter(@gl)
    #@lm = new LunchMap(@gl)
    @la = new LunchAddress(@gl)
    #@lm.create()
    @ls.sortByCloseness()
    @la.display()
  locate: ->
    @gl.locate( =>
      @ls.sortByCloseness()
      @la.display()
    )

window.LunchMapGUI = LunchMapGUI
