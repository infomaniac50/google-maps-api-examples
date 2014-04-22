$(function () {
  var map;
  var canvas;
  var panel;

  function initialize() {
    canvas = $("#map-canvas");
    panel = $("#map-panel");

    var mapOptions = {
      zoom: 15,
      center: new google.maps.LatLng(39.188155,-94.685882)
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
    console.log(canvas.height);
  }

  initialize();
});
