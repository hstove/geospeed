@SpeedLimit = React.createClass
  displayName: 'SpeedLimit'
  notAvailable: "n/a"
  lastPosition: null
  loading: false
  getInitialState: ->
    speedLimit: null
  componentDidMount: ->
    Geo.init
      success: ({coords}) =>
        if @lastPosition
          {latitude, longitude} = coords
          lat = @lastPosition.latitude; lng = @lastPosition.longitude
          distance = @getDistanceFromLatLonInKm(latitude, longitude, lat, lng)
          @lastPosition = coords
          if distance > 0.25
            @fetchSpeedLimit(coords)
        else
          @fetchSpeedLimit(coords)


  fetchSpeedLimit: (coords) ->
    @lastPosition = coords if coords
    {latitude, longitude} = @lastPosition
    url = "/speed_limit/show?latitude=#{latitude}&longitude=#{longitude}"
    @setState(loading: true)
    $.ajax
      url: url
      dataType: 'json'
      success: ({maxspeed, format, street}) =>
        analytics?.track('Loaded Speed Limit')
        @setState(loading: false)
        Geo.setFormat(format)
        if maxspeed
          @setState speedLimit: Math.round(maxspeed)
        else
          @setState speedLimit: @notAvailable
        @props.setStreet street
      error: ->


  render: ->
    speedClasses = classNames('fa fa-circle-o-notch fa-spin': !@state.speedLimit)
    containerStyle =
      borderColor: @props.textColor
    loadingClass = classNames
      'speed-loader': true
      'fa': true
      'fa-refresh': @state.loading
      'fa-spin': @state.loading

    <div id="speed-limit-container" style={containerStyle}>
      <i className={loadingClass}></i>
      <span id="speed-limit-label">SPEED<br/>LIMIT</span>
      <br/>
      <span id="speed-limit" className={speedClasses}>{@state.speedLimit}</span>
    </div>

  getDistanceFromLatLonInKm: (lat1, lon1, lat2, lon2) ->
    R = 6371
    # Radius of the earth in km
    dLat = @deg2rad(lat2 - lat1)
    dLon = @deg2rad(lon2 - lon1)
    a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(@deg2rad(lat1)) * Math.cos(@deg2rad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    d = R * c
    # Distance in km
    d

  deg2rad: (deg) ->
    deg * Math.PI / 180
