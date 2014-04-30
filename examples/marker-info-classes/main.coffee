class MapMaker
  constructor: (canvasElem, options) ->
    @canvas = $ canvasElem
    @map = new google.maps.Map canvasElem, options
    @markers = new MarkerCollection @map
    $(window).resize =>
      @onPageResize()
    $(window).trigger "resize"


  # Reflow the map
  onPageResize: ->
    @canvas.height @calculateRatio @canvas.width()

  ###
  Process each point in a Geometry, regardless of how deep the points may lie.
  @param {google.maps.Data.Geometry} geometry The structure to process
  @param {function(google.maps.LatLng)} callback A function to call on each
      LatLng point encountered (e.g. Array.push)
  @param {Object} thisArg The value of 'this' as provided to 'callback' (e.g.
      myArray)
  ###
  processPoints: (geometry, callback, thisArg) ->
    if geometry instanceof google.maps.LatLng
      callback.call thisArg, geometry
    else if geometry instanceof google.maps.Data.Point
      callback.call thisArg, geometry.get()
    else
      geometry.getArray().forEach (g) ->
        processPoints g, callback, thisArg

  calculateRatio: (width, ratio = 1.30) ->
    # Use the inverse ratio of the panel width.
    width * (1 / ratio)

  zoomFit: ->
    bounds = new google.maps.LatLngBounds

    for marker in @markers.markers
      @processPoints marker.getPosition(), bounds.extend, bounds
    @map.fitBounds bounds


class MarkerCollection
  constructor: (@map) ->
    @markers = []

  add: (coordinates, title, content) ->
    marker = new google.maps.Marker
      position: coordinates
      map: @map
      title: title ? ""
    @markers.push marker
    if content?
      google.maps.event.addListener marker, "click", () =>
        info = new google.maps.InfoWindow
          content: content

        info.open @map, marker

  clear: ->
    for marker in @markers
      marker.setMap null
      marker = null

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


