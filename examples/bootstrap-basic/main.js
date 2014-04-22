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

  // Reflow the map
  function onPageResize(ratio) {
    // Set defaults
    if (typeof(ratio) == "undefined") ratio = 1.30;

    // Use the inverse ratio of the panel width.
    $("#map-canvas").height($("#map-panel").outerWidth() * (1 / ratio));
  }

  initialize($("#map-canvas")[0]);
});
