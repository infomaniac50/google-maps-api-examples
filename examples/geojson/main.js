$(function () {
  var map;
  var canvas;
  var panel;

  function initialize(canvasElem, options) {
    map = new google.maps.Map(canvasElem, options);

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

  canvas = $("#map-canvas");
  panel = $("#map-panel");

  initialize(canvas[0], {
    // zoom: 15,
    // center: new google.maps.LatLng(39.188,-94.685)
  });

  loadMapData("geo.json");
});
