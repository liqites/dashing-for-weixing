class Dashing.Graph extends Dashing.Widget

  @accessor 'current', ->
#    return @get('displayedValue') if @get('displayedValue')
    points = @get('plan')
    console.log points
#    if points
#      points[points.length - 1].y

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
      series: [
        {
        color: "#fff",
        data: [{x:0, y:0}]
        }
      ]
    )
    for scale in [0..29]
      console.log scale
    @graph.series[0].data = [{x:1,y:10,time:"wzx"},{x:2,y:120},{x:3,y:15},{x:4,y:25,time:"dasa"}]
    wzx=[{x:1,y:10,time:"wzx"},{x:2,y:20},{x:3,y:15},{x:4,y:25}]
    x_axis = new Rickshaw.Graph.Axis.X({
      graph: @graph
      tickFormat:(x)->
        if x==2 then wzx[0].time
        else if x==4 then wzx[3].time
    })
    y_axis = new Rickshaw.Graph.Axis.Y(graph: @graph, tickFormat: Rickshaw.Fixtures.Number.formatKMBT)
    @graph.render()

  onData: (data) ->
    if @graph
      @graph.series[0].data = data.points
      @graph.render()
