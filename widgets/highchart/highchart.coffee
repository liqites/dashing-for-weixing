class Dashing.Highchart extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue
  @accessor 'category',->
    if @get('date') then @get('date')
  @accessor 'series',->
    if @get("graphtype")=="column"
      if @get("stacking")
          return [{
                type:"column"
                data: @get('unfinished')
                color: "#fd7171"
               }
              {
                type:"column"
                data: @get('finished')
                color:"#000"
              }
              {
                type:"spline"
                data: @get('plan')
                color:"#dcdcdc"
              }]
      else
        return [{
                  type:"column"
                  data: [10,20,30]
                  color: "#fd7171"
                }
                {
                  type:"column"
                  data: [10,20,30]
                  color:"#000"
                }]
    else if @get("graphtype")=="line"
      return [{
                type:"line"
                data: @get('points')
                color: "#fff"
              }]
    else if @get("graphtype")=="bar"
      console.log @get("b")
      return [{
        type:"bar"
        data: [10,20,30]
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
          stacking:@get("stacking")
          borderWidth:0
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
#    @chart = new Highcharts.Chart
#      chart:
#        renderTo: "HCcontainer"
#        type: "bar"
#
#        series: [
#          name: "Tokyo"
#          data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
#        ]