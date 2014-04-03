# dashing.js is located in the dashing framework
# It includes jquery & batman for you.
#= require dashing.js
#= require highcharts
#= require_directory .
#= require_tree ../../widgets
#= require dashing.config

console.log("Yeah! The dashboard has started!")

Dashing.on 'ready', ->
  Dashing.widget_margins ||= [5, 5]
  Dashing.widget_base_dimensions ||= [188,216]
  Dashing.numColumns ||= 4

  contentWidth = (Dashing.widget_base_dimensions[0] + Dashing.widget_margins[0] * 2) * Dashing.numColumns

  #gridster = $('.gridster ul:first').gridster({
  #  widget_margins: Dashing.widget_margins,
  #  widget_base_dimensions: Dashing.widget_base_dimensions,
  #  avoid_overlapped_widgets: !Dashing.customGridsterLayout,
  #  draggable:{
  #    start: Dashing.currentWidgetPositions = Dashing.getWidgetPositions()
  #  }
  #}).data('gridster')
#        stop: Dashing.showGridsterInstructions
      #start: -> Dashing.currentWidgetPositions = Dashing.getWidgetPositions()

  Batman.setImmediate ->
    $('.gridster').width(contentWidth)
    #gridster
    $('.gridster ul:first').gridster
      widget_margins: Dashing.widget_margins
      widget_base_dimensions: Dashing.widget_base_dimensions
      avoid_overlapped_widgets: !Dashing.customGridsterLayout
      draggable:
#        stop: Dashing.showGridsterInstructions
        start: -> Dashing.currentWidgetPositions = Dashing.getWidgetPositions()