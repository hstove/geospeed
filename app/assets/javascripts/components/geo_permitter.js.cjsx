@GeoPermitter = React.createClass
  displayName: "GeoPermitter"
  getInitialState: ->
    loading: false
  getPermission: ->
    @setState(loading: true)
    @props.getPermission()
  render: ->
    <div className="text-center">
      <br/>
      <br/>
      <h3>
        Geospeed needs your permission to access location.
      </h3>
      <br/>
      <br/>
      <h3>
        Tap the button below to start that short process.
      </h3>
      <br/>
      <br/>
      <p>
        <a href="#" className="btn btn-primary btn-lg" onClick={@getPermission}
          disabled={@loading}>
          Give Us Location Permission
        </a>
      </p>
      <br/>
      <br/>
      <h3>
        We promise to never ever share your location with anyone.
      </h3>
    </div>
