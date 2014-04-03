class Dashing.Stackbar extends Dashing.Widget

  @accessor 'current', ->
    return @get('displayedValue') if @get('displayedValue')
    points = @get('points')
    console.log
    if points
      points[points.length - 1].y

  ready: ->
    container = $(@node).parent()
    # Gross hacks. Let's fix this.
    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))
    @graph = new Rickshaw.Graph(
      element: @node
      width: width
      height: height
      renderer: @get("graphtype")
      series: [{
          data: [ { x: 0, y: 40 }, { x: 1, y: 49 }]
          color: 'yellow'
        }, {
          data: [ { x: 0, y: 20 }, { x: 1, y: 24 }]
          color: 'red'
      }]
    )
    x_axis = new Rickshaw.Graph.Axis.Time(
      graph: @graph
    )
    y_axis = new Rickshaw.Graph.Axis.Y(graph: @graph, tickFormat: Rickshaw.Fixtures.Number.formatKMBT)
    @graph.render()

  onData: (data) ->
    if @graph
      @graph.series[0].data = data.points
      @graph.render()
