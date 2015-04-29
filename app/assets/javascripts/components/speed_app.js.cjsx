#= require components/speed
#= require components/speed_limit

@SpeedApp = React.createClass
  displayName: 'SpeedApp'
  render: ->
    <div>
      <Speed speedFormat={@props.speedFormat}/>
      <SpeedLimit speedFormat={@props.speedFormat} textColor={@props.textColor}
        ref="speedLimit"/>
    </div>

  refresh: ->
    @refs.speedLimit.fetchSpeedLimit()
