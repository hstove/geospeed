class @Storage
  @get: (key) ->
    try
      JSON.parse localStorage[key]
    catch
      undefined


  @set: (key, value) ->
    localStorage[key] = JSON.stringify value
    value

  @state: (keys) ->
    state = {}
    for key in keys
      state[key] = @get(key)
    state
