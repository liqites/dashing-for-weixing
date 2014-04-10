class Dashing.List extends Dashing.Widget
  @accessor 'today',->
    new Date().toISOString().split("T")[0]
  @accessor 'items',->
    if @get("lack")
      items=[
        {label:"今日计划数",value:@get("plan")[7][7]},
        {label:"今日完工数",value:@get("finished")[7]},
        {label:"今日缺数",value:@get("unfinished")[7]}
      ]
  ready: ->
    if @get('unordered')
      $(@node).find('ol').remove()
    else
      $(@node).find('ul').remove()
