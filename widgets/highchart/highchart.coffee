class Dashing.Highchart extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue
  @accessor 'category',->
    labels=[["塑钢二车间","塑钢三车间","尼龙一车间"],["金属一车间","金属二车间","尼龙三车间"],["塑钢二车间","塑钢三车间","尼龙一车间"],["金属一车间","金属二车间","尼龙三车间"]]
    if @get('date')
      return @get('date')
    if @get("graphtype")=="bar"
      if @get("columns")=="five"
          return ["美特斯邦威","森马","Only","H&M","Zara"]
      if @get("columns")=="three"
        if @get("label")
          return labels[@get("label")-1]
        else
          return ["羽绒服","运动服","外套"]
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
        if @get("columns") == 'three'
          return [
                  {
                    type:"column"
                    name:"台州"
                    data: @get("a")
                    color: "#fd7171"
                  }
                  {
                    type:"column"
                    name:"上海"
                    data: @get("b")
                    color:"#000"
                  }
                  {
                    type:"column"
                    name:"温州"
                    data:@get("c")
                    color:"#fff"
                  }]
        else if @get("columns") == 'one'
          return [
                  {
                    type:"column"
                    data: @get("value")
                    color: "#fff"
                  }]
        else if @get("columns") == 'two'
          return [
                  {
                    type:"column"
                    name:"塑钢一车间"
                    data: [@get("a")]
                    color: "#fd7171"
                  },{
                    type:"column"
                    name:"全厂"
                    data: [@get("b")]
                    color: "#000"
                  }]
        else
          return [{
                  type:"column"
                  name:"1"
                  data: [[40],50,30]
                  color: "#fd7171"
                }
                {
                  type:"column"
                  name:"1"
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
      if @get("columns")=="five"
          return [{
                  type:"bar"
                  data: [@get("a"),@get("b"),@get("c"),@get("d"),@get("e")]
                  color: "#fff"
                }]
      else if @get("columns")=="three"
          return [{
                  type:"bar"
                  data: [@get("a"),@get("b"),@get("c")]
                  color: "#fff"
          }]
      else
          return [{
                  type:"bar"
                  data: [10,20,30]
                  color: "#fff"
                  }]
    else if @get("graphtype")=="pie"

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
        bar:
          color:"#fff"
        column:
          stacking:@get("stacking")
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
#    @chart = new Highcharts.Chart
#      chart:
#        renderTo: "HCcontainer"
#        type: "bar"
#
#        series: [
#          name: "Tokyo"
#          data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
#        ]