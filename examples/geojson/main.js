$(function () {
  var map;
  var canvas;
  var panel;

  function initialize() {
    canvas = $("#map-canvas");
    panel = $("#map-panel");

    var mapOptions = {
      zoom: 10,
      center: new google.maps.LatLng(39.188,-94.685)
    };

    map = new google.maps.Map(canvas[0], mapOptions);
    $(window).resize(onPageResize);
    onPageResize();
  }

  // Reflow the map
  function onPageResize(ratio) {
    // Set defaults
    if (typeof(ratio) == "undefined") ratio = 1.30;

    // Use the inverse ratio of the panel width.
    canvas.height(panel.outerWidth() * (1 / ratio));
  }

  function loadMapData(url) {
    var p = $.getJSON(url);

    p.done(function(geojson) {
      map.data.addGeoJson(geojson);
      zoom(map);
    });
  }

  initialize();
  loadMapData("geo.json");
});
