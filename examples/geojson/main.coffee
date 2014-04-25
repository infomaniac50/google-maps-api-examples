$ () ->
  map = null

  initialize = (canvasElem, options) ->
    map = new google.maps.Map canvasElem, options
    $(window).resize () ->
      onPageResize canvasElem
    $(window).trigger "resize"

  loadMapData = (url) ->
    p = $.getJSON url

    p.done((geojson) ->
      map.data.addGeoJson geojson
      id = 0

      $("#map-panel-items").html (emitPanelItem "map-panel-items", feature.properties.name, """
            Type: #{ feature.geometry.type }<br>
            Longitude: #{ Math.round feature.geometry.coordinates[0], 3 }<br>
            Latitude: #{ Math.round feature.geometry.coordinates[1], 3 }<br>
            """, ++id for feature in geojson.features)

      zoom map
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

  loadMapData "/ajax/geo.json"
