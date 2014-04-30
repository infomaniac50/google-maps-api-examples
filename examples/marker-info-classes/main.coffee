$ () ->
  canvas = $ "#map-canvas"
  panel = $ "#map-panel"
  map = new MapMaker canvas[0], {
    # zoom: 15,
    # center: new google.maps.LatLng(39.188,-94.685)
  }

  url = "/ajax/flat.json"
  p = $.getJSON url

  p.done (flatjson) =>
    map.markers.clear()

    for feature in flatjson
      coordinates = new google.maps.LatLng feature.coordinates.latitude, feature.coordinates.longitude
      marker = map.markers.add coordinates, feature.title, feature.content

    map.zoomFit()
