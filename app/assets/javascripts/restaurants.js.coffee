# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class GeoLocator
  locateUser: (callback, callback_e) ->
    if window.navigator.geolocation
      console.log 'Locating'
      window.navigator.geolocation.getCurrentPosition(callback, callback_e);
    else
      alert 'Geololcation is not supported. :/'

class LunchLocator
  

window.gl = new GeoLocator
window.ll = new LunchLocator
