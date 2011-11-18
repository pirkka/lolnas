// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require restaurants

Lolnas = {
  supportsSVG: function () {
    return !!document.createElementNS && !!document.createElementNS('http://www.w3.org/2000/svg', "svg").createSVGRect;
  }
};

$(function () {
  // check for SVG support
  if (!Lolnas.supportsSVG()) {
    $('img#logo').attr('src', '/assets/lolnas.gif');
  }
});