@SpeedLimit = React.createClass
  displayName: 'SpeedLimit'
  notAvailable: "n/a"
  getInitialState: ->
    speedLimit: null
  componentDidMount: ->
    Geo.init
      success: ({coords}) =>
        {latitude, longitude} = coords
        url = "/speed_limit/show?latitude=#{latitude}&longitude=#{longitude}"
        $.ajax
          url: url
          dataType: 'json'
          success: ({maxspeed, format}) =>
            Geo.setFormat(format)
            if maxspeed
              @setState speedLimit: Math.round(maxspeed)
            else
              @setState speedLimit: @notAvailable
          error: ->


  render: ->
    speedClasses = classNames('fa fa-circle-o-notch fa-spin': !@state.speedLimit)
    containerStyle =
      borderColor: @props.textColor
    <div id="speed-limit-container" style={containerStyle}>
      <span id="speed-limit-label">SPEED<br/>LIMIT</span>
      <br/>
      <span id="speed-limit" className={speedClasses}>{@state.speedLimit}</span>
    </div>
