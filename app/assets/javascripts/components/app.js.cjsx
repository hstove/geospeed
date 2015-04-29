#= require components/geo_permitter
#= require components/invalid_browser
#= require components/intro
#= require components/speed_app
#= require colors

watchId = null

@App = React.createClass
  displayName: 'App'
  getInitialState: ->
    state = Storage.state [
      'introed', 'geoAllowed', 'lastPosition', 'speedFormat', 'backgroundColor',
      'textColor'
    ]
    state.geoError = null
    state.backgroundColor ||= 'rgba(142, 68, 173,1.0)'
    state.textColor ||= 'rgba(236, 240, 241,1.0)'
    state

  render: ->
    @dumpState()

    if @state.introed
      if @state.geoAllowed
        appInner = <SpeedApp speedFormat={@state.speedFormat}
          textColor={@state.textColor}/>
      else if !navigator?.geolocation
        appInner = <InvalidBrowser />
      else
        appInner = <GeoPermitter getPermission={@getPermission}/>
      inner = <div key="app-inner">
        {appInner}
      </div>
    else
      inner = <Intro getStarted={@getStarted}/>

    appStyles =
      backgroundColor: @state.backgroundColor
      color: @state.textColor

    <div id="app" style={appStyles}>
      <div className="container">
        <div className="row">
          <div className="col-xs-12">
            {inner}
          </div>
        </div>
      </div>
      <Settings textColor={@state.textColor} backgroundColor={@state.backgroundColor}/>
      <ColorPicker backgroundColor={@state.backgroundColor} saveColor={@saveColor}/>
    </div>

  componentDidMount: ->
    Geo.getFormatUpdates(@)

  dumpState: ->
    for key, val of @state
      Storage.set(key, val)

  getStarted: ->
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
    @setState
      geoAllowed: true

  positionError: (message) ->
    @setState geoError: message

  saveColor: (color) ->
    @setState backgroundColor: color
