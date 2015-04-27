#= require components/geo_permitter
#= require components/invalid_browser
#= require components/intro
#= require components/speed_app

watchId = null

@App = React.createClass
  displayName: 'App'
  getInitialState: ->
    state = Storage.state ['introed', 'geoAllowed', 'lastPosition', 'speedFormat']
    state.geoError = null
    state.speedFormat ||= 'MPH'
    state

  render: ->
    @dumpState()

    if @state.introed
      if @state.geoAllowed
        appInner = <SpeedApp speedFormat={@state.speedFormat}/>
      else if !navigator?.geolocation
        appInner = <InvalidBrowser />
      else
        appInner = <GeoPermitter getPermission={@getPermission}/>
      inner = <div key="app-inner">
        {appInner}
      </div>
    else
      inner = <Intro getStarted={@getStarted}/>

    <div className="row">
      <div className="col-xs-12">
        {inner}
      </div>
    </div>

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
