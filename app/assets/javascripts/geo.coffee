class @Geo
  @successCbs: []
  @errorCbs: []

  @speedFormatComponents: []
  @getFormatUpdates: (component) -> @speedFormatComponents.push component
  @setFormat: (format) ->
    for component in @speedFormatComponents
      component.setState(speedFormat: format)

  @watchId: null
  @init: (opts) ->
    options =
      enableHighAccuracy: true
      maximumAge: 0
      timeout: 10000
    if opts.getCurrentPosition
      navigator.geolocation.getCurrentPosition opts.success, opts.error, options
    else
      @successCbs.push opts.success
      @errorCbs.push opts.error
      @watchId ||= navigator.geolocation.watchPosition @positionSuccess, @positionError, options
      true

  @positionSuccess: (position) ->
    cb(position) for cb in Geo.successCbs

  @positionError: (error) ->
    message = Geo.messageForError(error)
    cb(message) for cb in Geo.errorCbs

  @messageForError: (error) ->
    {code} = error
    message = null
    switch code
      when error.PERMISSION_DENIED
        message = "You need to give us permission to use your location to use this app."
      when error.POSITION_UNAVAILABLE, error.PERMISSION_DENIED_TIMEOUT
        message = "Your computer was not able to get a location."
    message
