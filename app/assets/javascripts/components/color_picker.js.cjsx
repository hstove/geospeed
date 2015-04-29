@ColorPicker = React.createClass
  displayName: 'ColorPicker'
  render: ->
    colors = Colors.map (color) =>
      <div key={color} className="col-sm-4 col-xs-4" style={textAlign: 'center'} onClick={@setBackgroundColor}>
        <i className="color-square-big" style={backgroundColor: color}></i>
      </div>

    <div className="modal fade" id="color-modal">
      <div className="modal-dialog">
        <div className="modal-content">
          <div className="modal-body">
            <div className="row">
              {colors}
            </div>
          </div>
        </div>
      </div>
    </div>

  setBackgroundColor: (e) ->
    color = $(e.currentTarget).find('i').css('background-color')
    @props.saveColor(color)
    $('#color-modal').modal('hide')
