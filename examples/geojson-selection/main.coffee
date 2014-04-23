$ () ->
  map = null

  initialize = (canvasElem, options) ->
    map = new google.maps.Map canvasElem, options
    $(window).resize(onPageResize)
    onPageResize()

  # Reflow the map
  onPageResize = (ratio) ->
    # Set defaults
    ratio = 1.30 unless ratio?

    # Use the inverse ratio of the panel width.
    canvas.height panel.outerWidth() * (1 / ratio)


  emitPanelItem = (parent, title, body, id) ->
    """
    <div class="panel panel-default">
      <div class="panel-heading">
        <a href="##{ id }" class="panel-title collapsed" data-toggle="collapse" data-parent="##{ parent }">
          #{ title }
        </a>
      </div>
    </div>
    <div class="panel-collapse collapse" id="#{ id }">
      <div class="panel-body">
        #{ body }
      </div>
    </div>
    """

  loadMapData = (url) ->
    p = $.getJSON url

    p.done((geojson) ->
      map.data.addGeoJson geojson
      id = 0

      $("#map-panel-items").html (emitPanelItem "map-panel-items", feature.properties.name, """
            Type: #{ feature.geometry.type }<br>
            Latitude: #{ Math.round feature.geometry.coordinates[0], 3 }<br>
            Longitude: #{ Math.round feature.geometry.coordinates[1], 3 }<br>
            """, ++id for feature in geojson.features)

      zoom map
      ;
    )

  canvas = $ "#map-canvas"
  panel = $ "#map-panel"

  initialize canvas[0], {
    # zoom: 15,
    # center: new google.maps.LatLng(39.188,-94.685)
  }

  loadMapData "geo.json"

