@Speed = React.createClass
  getInitialState: ->
    speed: 0
  componentDidMount: ->
    Geo.init
      success: ({coords}) =>
        console.log 'speed', coords
        if speed = coords.speed
          if @props.speedFormat == 'MPH'
            speed *= 2.23694
          else
            speed *= 3.6
          @setState speed: speed
  render: ->
    <div id="speed-container">
      <span className="speed">{@state.speed} {@props.speedFormat}</span>
    </div>
