class MapMaker
  constructor: (canvasElem, options) ->
    @canvas = $ canvasElem
    @map = new google.maps.Map canvasElem, options
    @markers = new MarkerCollection @map
    $(window).resize =>
      @resize()
    $(window).trigger "resize"


  # Reflow the map
  resize: (ratio = 1.30) ->
    height = @canvas.width() * (1 / ratio)
    # Use the inverse ratio of the panel width.
    @canvas.height(height)

  zoomFit: ->
    ###
    Process each point in a Geometry, regardless of how deep the points may lie.
    @param {google.maps.Data.Geometry} geometry The structure to process
    @param {function(google.maps.LatLng)} callback A function to call on each
        LatLng point encountered (e.g. Array.push)
    @param {Object} thisArg The value of 'this' as provided to 'callback' (e.g.
        myArray)
    ###
    processPoints = (geometry, callback, thisArg) ->
      if geometry instanceof google.maps.LatLng
        callback.call thisArg, geometry
      else if geometry instanceof google.maps.Data.Point
        callback.call thisArg, geometry.get()
      else
        geometry.getArray().forEach (g) ->
          processPoints g, callback, thisArg
    bounds = new google.maps.LatLngBounds

    for marker in @markers.markers
      processPoints marker.getPosition(), bounds.extend, bounds
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
