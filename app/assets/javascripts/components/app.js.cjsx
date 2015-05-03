#= require components/invalid_browser
#= require components/intro
#= require components/speed_app
#= require components/geo_blocked
#= require colors

watchId = null

@App = React.createClass
  displayName: 'App'
  getInitialState: ->
    state = Storage.state [
      'introed', 'geoAllowed', 'lastPosition', 'speedFormat', 'backgroundColor',
      'textColor', 'flipped'
    ]
    state.geoError = null
    state.backgroundColor ||= 'rgba(142, 68, 173,1.0)'
    state.textColor ||= 'rgba(236, 240, 241,1.0)'
    state

  render: ->
    @dumpState()

    if @state.geoAllowed
      appInner = <SpeedApp speedFormat={@state.speedFormat} ref="speedApp"
        textColor={@state.textColor}/>
    else if @state.geoError
      appInner = <GeoBlocked />
    else if !navigator?.geolocation
      appInner = <InvalidBrowser />
    else
      appInner = <Intro getStarted={@getPermission}/>
    inner = <div key="app-inner">
      {appInner}
    </div>

    appStyles =
      backgroundColor: @state.backgroundColor
      color: @state.textColor

    appClass = classNames flipped: !!@state.flipped
    <div id="app" style={appStyles} className={appClass}>
      <div className="container">
        <div className="row">
          <div className="col-xs-12">
            {inner}
          </div>
        </div>
      </div>
      <Settings textColor={@state.textColor} backgroundColor={@state.backgroundColor}
        refresh={@refresh} flip={@flip}/>
      <ColorPicker backgroundColor={@state.backgroundColor} saveColor={@saveColor}/>
    </div>

  componentDidMount: ->
    Geo.getFormatUpdates(@)

  dumpState: ->
    for key, val of @state
      Storage.set(key, val)

  getStarted: ->
    analytics?.track('Got Started')
    @setState(introed: true)
    false

  getPermission: ->
    opts =
      enableHighAccuracy: true
      maximumAge: 0
      timeout: 10000
    Geo.init
      success: @positionSuccess
      error: @positionError
      getCurrentPosition: true
    true

  positionSuccess: (position) ->
    analytics?.track('Gave Geo Permission')
    @setState
      geoAllowed: true

  positionError: (message) ->
    @setState geoError: message

  saveColor: (color) ->
    @setState backgroundColor: color

  refresh: ->
    analytics?.track 'Refresh'
    @refs.speedApp.refresh()
    console.log 'refresh'

  flip: ->
    analytics?.track "Flip"
    @setState flipped: !@state.flipped
