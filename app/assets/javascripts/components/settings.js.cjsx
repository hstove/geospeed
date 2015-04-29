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
        <li onClick={@props.refresh}>
          <i className="fa fa-refresh"></i>
        </li>
        <li onClick={@props.flip}>
          <i className="fa fa-arrows-h"></i>
        </li>
        <li onClick={@showColorPicker}>
          <i className="color-square" style={borderColor: @props.textColor}>
            {colors}
          </i>
        </li>
        <li>
          <a href="https://github.com/hstove/geospeed" target="_blank" style={textStyle}>
            <i className="fa fa-github"></i>
          </a>
        </li>
        <li>
          <a href="https://twitter.com/home?status=Geospeed%20-%20an%20app%20for%20getting%20the%20speed%20limit%20wherever%20you%20are.%20http://geospeed.co" target="_blank" style={textStyle}>
            <i className="fa fa-twitter"></i>
          </a>
        </li>
        <li>
          <a href="https://www.facebook.com/sharer/sharer.php?u=http://geospeed.co" target="_blank" style={textStyle}>
            <i className="fa fa-facebook"></i>
          </a>
        </li>
      </ul>
    </div>

  toggleExpanded: ->
    @setState(expanded: !@state.expanded)

  showColorPicker: ->
    $('#color-modal').modal('show')
    @setState expanded: false
