class Dashing.List extends Dashing.Widget
  @accessor 'today',->
    new Date().toISOString().split("T")[0]
  ready: ->
    if @get('unordered')
      $(@node).find('ol').remove()
    else
      $(@node).find('ul').remove()
