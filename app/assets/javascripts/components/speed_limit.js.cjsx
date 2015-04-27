@SpeedLimit = React.createClass
  displayName: 'SpeedLimit'
  notAvailable: "n/a"
  getInitialState: ->
    speedLimit: @notAvailable
  componentDidMount: ->
    Geo.init
      success: ({coords}) =>
        {latitude, longitude} = coords
        url = "/speed_limit/show?latitude=#{latitude}&longitude=#{longitude}"
        $.ajax
          url: url
          dataType: 'json'
          success: ({maxspeed}) =>
            if maxspeed
              if @props.speedFormat != 'MPH'
                maxspeed *= 1.60934
              @setState speedLimit: Math.round(maxspeed)
            else
              @setState speedLimit: @notAvailable
          error: ->


  render: ->
    <div id="speed-limit-container">
      <span id="speed-limit">{@state.speedLimit}</span>
    </div>
