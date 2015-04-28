@Speed = React.createClass
  getInitialState: ->
    speed: 0
    speedInMPS: 0
  componentDidMount: ->
    Geo.init
      success: ({coords}) =>
        console.log 'speed', coords
        if speed = coords.speed
          @setState speedInMPS: speed
  render: ->
    speed = @state.speedInMPS
    if @props.speedFormat == 'mph'
      speed *= 2.23694
    else
      speed *= 3.6
    <div id="speed-container">
      <span className="speed">{Math.round(speed)} {@props.speedFormat}</span>
    </div>
