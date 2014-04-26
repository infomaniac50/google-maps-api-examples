$ () ->
  map = null
  markers = null

  initialize = (canvasElem, options) ->
    map = new google.maps.Map canvasElem, options
    $(window).resize () ->
      onPageResize canvasElem
    $(window).trigger "resize"

  loadMapData = (url) ->
    p = $.getJSON url

    p.done((flatjson) ->
      markers = []

      bounds = new google.maps.LatLngBounds

      for feature in flatjson
        coordinates = new google.maps.LatLng feature.coordinates.latitude, feature.coordinates.longitude
        marker = infoMarker feature.title, feature.content, coordinates
        marker.setMap map
        markers.push marker
        processPoints coordinates, bounds.extend, bounds

      map.fitBounds bounds
    )

  # Reflow the map
  onPageResize = () ->
    canvas.height calculateRatio panel.width()

  canvas = $ "#map-canvas"
  panel = $ "#map-panel"

  initialize canvas[0], {
    # zoom: 15,
    # center: new google.maps.LatLng(39.188,-94.685)
  }

  loadMapData "/ajax/flat.json"
