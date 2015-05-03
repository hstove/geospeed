@Intro = React.createClass
  displayName: 'Intro'
  getInitialState: ->
    loading: false
  render: ->
    <div className="text-center row">
      <div className="col-xs-12 col-xs-offset-0">
        <br/>
        <br/>
        <h4>
          Geospeed is an app for displaying the current speed limit
          wherever you are.
        </h4>
        <br/>
        <br/>
        <h4>
          We need your permission to get your current location, otherwise
          we can&apos;t get nearby speed limits.
        </h4>
        <br/>
        <p>
          <a href="#" className="btn btn-success btn-lg btn-xl" onClick={@getStarted}>
            {if @state.loading then <i className="fa fa-circle-o-notch fa-spin"/> else 'Continue'}
          </a>
        </p>
        <br/>
        <h4>
          We promise to never <strong>ever</strong> share your location with anyone.
        </h4>
      </div>
    </div>

  getStarted: ->
    @setState loading: true
    @props.getStarted()
