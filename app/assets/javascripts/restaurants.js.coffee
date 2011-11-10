# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class GeoLocator
  constructor: (@lat, @lon) ->
  setCoordinates: (position) ->
    lat = position.coords.latitude
    lon = position.coords.longitude
    console.log 'Setting location to ' + lat + ',' + lon
  locationFailed: ->
    alert 'Failed to geololcate (o __ o)¨'
  locate: (callback, callback_e) ->
    if window.navigator.geolocation
      console.log 'Locating'
      window.navigator.geolocation.getCurrentPosition(this.setCoordinates, this.locationFailed);
    else
      alert 'Geololcation is not supported. :/'

class LunchSorter
  sortLunches: (lat, lon) ->
    console.log 'Sorting lunches'

window.gl = new GeoLocator
window.ls = new LunchSorter
