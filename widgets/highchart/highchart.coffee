class Dashing.Highchart extends Dashing.Widget

  @accessor 'current', Dashing.AnimatedValue

  ready: ->
    # This is fired when the widget is done being rendered
    @chart = new Highcharts.Chart
      chart:
        renderTo: "HCcontainer"
        type: "bar"

      series: [
        name: "Tokyo"
        data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
      ,
        name: "New York"
        data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
      ]

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
    @chart = new Highcharts.Chart
      chart:
        renderTo: "HCcontainer"
        type: "bar"

        series: [
          name: "Tokyo"
          data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
        ,
          name: "New York"
          data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
        ]