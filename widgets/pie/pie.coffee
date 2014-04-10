class Dashing.Pie extends Dashing.Widget
 @accessor 'current', Dashing.AnimatedValue
 @accessor 'category',->

 @accessor 'series',->
    value=@get("value")
    count=value.length-1
    data=[]
    for i in [0..count]
      data.push [value[i].name,value[i].val]
    return [{
        type:"pie"
        data: data
        color: "#fff"
    }]
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
