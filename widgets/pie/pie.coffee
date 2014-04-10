class Dashing.Pie extends Dashing.Widget
 @accessor 'current', Dashing.AnimatedValue
 @accessor 'category',->

 @accessor 'series',->


    if @get("columns") == "two"
      return [{
        type:"pie"
        data: [["每日完工数",@get("a")],["计划数",@get("b")]]
        color: "#fff"
      }]
    else
      return [{
        type:"pie"
        data: [["台州",@get("a")],["上海",@get("b")],["温州",@get("c")],["大洋外贸",@get("d")],["成都",@get("e")],["广东",@get("f")],["青岛",@get("g")],["石家庄",@get("h")],["厦门",@get("i")]]
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
