class Dashing.Meter extends Dashing.Widget

  @accessor 'value', Dashing.AnimatedValue
#  @accessor 'value',->
#    value=@get("a") / @get("b") * 100
#    return "#{value.toFixed(0)}"
  constructor: ->
    super
    @observe 'value', (value) ->
      console.log value
      $(@node).find(".meter").val(value).trigger('change')

  ready: ->
    meter = $(@node).find(".meter")
    meter.attr("data-bgcolor", meter.css("background-color"))
    meter.attr("data-fgcolor", meter.css("color"))
    meter.knob()
