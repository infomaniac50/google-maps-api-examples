$(function () {
  var map;

  function initialize(elem) {
    var mapOptions = {
      zoom: 10,
      center: new google.maps.LatLng(39.188,-94.685)
    };

    map = new google.maps.Map(elem, mapOptions);
    $(window).resize(onPageResize);
    onPageResize();
  }

  function onPageResize() {
    // Reflow the map
    // $("#map-panel").outerHeight(window.innerHeight);
  }

  function loadMapData(url) {
    var p = $.getJSON(url);

    p.done(function(geojson) {
      map.data.addGeoJson(geojson);
      zoom(map);
    });
  }

  initialize($("#map-canvas")[0]);
  loadMapData("geo.json");
});
