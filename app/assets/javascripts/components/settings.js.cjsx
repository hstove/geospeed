@Settings = React.createClass
  displayName: 'Settings'
  getInitialState: ->
    expanded: false
    colorPicker: false
  render: ->
    style =
      color: @props.textColor
      border: "1px solid #{@props.textColor}"
    textStyle =
      color: @props.textColor
    classes = classNames(expanded: @state.expanded, 'color-picker': @state.colorPicker)

    colors = Colors.map (color) ->
      <div key={"mini-"+color} className="mini-color-square" style={backgroundColor: color}></div>


    <div id="settings-container" style={style} className={classes}>
      <ul>
        <li onClick={@toggleExpanded}>
          <i className="fa fa-cog" id="settings-activate"></i>
        </li>
        <li>
          <a href="https://github.com/hstove/geospeed" target="_blank" style={textStyle}>
            <i className="fa fa-github"></i>
          </a>
        </li>
        <li onClick={@showColorPicker}>
          <i className="color-square" style={borderColor: @props.textColor}>
            {colors}
          </i>
        </li>
      </ul>
    </div>

  toggleExpanded: ->
    @setState(expanded: !@state.expanded)

  showColorPicker: ->
    $('#color-modal').modal('show')
    @setState expanded: false
