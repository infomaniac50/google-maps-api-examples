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

  canvas = $("#map-canvas");
  panel = $("#map-panel");

  initialize(canvas[0], {
    zoom: 15,
    center: new google.maps.LatLng(39.188155,-94.685882)
  });
});
