class Dashing.List extends Dashing.Widget
  @accessor 'today',->
    new Date().toISOString().split("T")[0]
  @accessor 'items',->
    if @get("lack")
      items=[
        {label:"当前计划数",value:10},
        {label:"完工数",value:20},
        {label:"缺数",value:30}
      ]
  ready: ->
    if @get('unordered')
      $(@node).find('ol').remove()
    else
      $(@node).find('ul').remove()
