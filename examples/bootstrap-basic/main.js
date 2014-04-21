$(function () {
  var map;

  function initialize(elem) {
    var mapOptions = {
      zoom: 15,
      center: new google.maps.LatLng(39.188155,-94.685882)
    };

    map = new google.maps.Map(elem, mapOptions);
    $(window).resize(onPageResize);
    onPageResize();
  }

  function onPageResize() {
    // Reflow the map
    $("#map-canvas").outerHeight(window.innerHeight);
  }

  initialize($("#map-canvas")[0]);
});
