class Dashing.Graph extends Dashing.Widget
  @accessor 'lastDay',->
    date=@get('date')
    if date then date[date.length-1]
  @accessor 'dateRange',->
    date=@get('date')
    if date then date[0]+" ~ "+date[date.length-1]
  @accessor 'current', -> if @get('output_daily')
    @get('output_daily')

  ready: ->
    container = $(@node).parent()
    console.log @get('output')
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
    @graph.series[0].data=[]
    plan = @get('output')
    date = @get('date')
    for scale in [0..29]
      @graph.series[0].data.push {x:scale,y:plan[scale]}
    x_axis = new Rickshaw.Graph.Axis.X({
      graph: @graph
      tickFormat:(x)->

    })
    y_axis = new Rickshaw.Graph.Axis.Y(graph: @graph, tickFormat: Rickshaw.Fixtures.Number.formatKMBT)
    @graph.render()

  onData: (data) ->
    if @graph
      @graph.series[0].data = data.points
      @graph.render()
