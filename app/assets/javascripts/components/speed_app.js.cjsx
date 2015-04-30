#= require components/speed
#= require components/speed_limit
#= require components/street

@SpeedApp = React.createClass
  displayName: 'SpeedApp'
  getInitialState: ->
    street: ''

  render: ->
    <div>
      <Speed speedFormat={@props.speedFormat}/>
      <SpeedLimit speedFormat={@props.speedFormat} textColor={@props.textColor}
        ref="speedLimit" setStreet={@setStreet} />
      <Street street={@state.street}/>
    </div>

  refresh: ->
    @refs.speedLimit.fetchSpeedLimit()

  setStreet: (street) ->
    @setState street: street
