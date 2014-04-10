class Dashing.X1y2 extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue
  @accessor 'category',->
    return @get("date")
  @accessor 'series',->
     value=@get("value")
     series=[]
     colors=["#fd7171","#000","#dcdcdc"]
     count=value.length-1
     for i in [0..count]
       series.push {
                      type:"column"
                      name:value[i].title
                      color: colors[i]
                      data:value[i].value
                  }
     return series
  ready: ->
    # This is fired when the widget is done being rendered
    @chart = new Highcharts.Chart
      chart:
        renderTo: @get("id")
        backgroundColor:"rgba(0,0,0,0)"
      title:""
      legend:
        enabled:if @get("legend") then true else false
        borderColor:"rgba(255,255,255,0.7)"
        itemMarginBottom:2
        itemStyle:
          fontSize:"10px"
      tooltip:
        enabled:false
      credits:
        enabled:false
      plotOptions:
        bar:
          color:"#fff"
        column:
          borderWidth:0
        pie:
          showInLegend:true
      xAxis:
        lineColor:
          color:"rgba(0,0,0,0)"
        categories: @get("category")
        labels:
          style:
            color:'#fff'
            font: 'normal 10px Verdana, sans-serif',
        tickColor:"rgba(0,0,0,0)"
      yAxis:
        title:null
        gridLineColor:"rgba(255,255,255,0.1)"
        labels:
          style:
            color:'rgba(255,255,255,0.5)'
      series: @get('series')

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
