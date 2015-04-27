@Intro = React.createClass
  displayName: 'Intro'
  render: ->
    @dumpState()
    <div className="text-center">
      <br/>
      <br/>
      <br/>
      <br/>
      <h3>
        Geospeed is an app for getting the current speed limit
        when you are driving.
      </h3>
      <br/>
      <br/>
      <br/>
      <br/>
      <p>
        <a href="#" className="btn btn-success btn-lg" onClick={@props.getStarted}>
          Get Started
        </a>
      </p>
    </div>

  dumpState: ->
    for key, val of @state
      Storage.set(key, val)
