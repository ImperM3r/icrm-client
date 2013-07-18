class @ICRMClient.Widget.RootController extends @ICRMClient.Base

  # Input parameters:
  # visible
  # parent_el
  constructor: (options) ->
    @window         = new ICRMClient.Widget.WindowView visitor_id: options.visitor_id
    @starter_button = new ICRMClient.Widget.StarterButtonView
      window: @window

    @visible = options.visible
    @parent_el = options.parent_el
    @_render()

  _render: ->
    if @visible
      @window.append_to @$(@parent_el)
      @$(@parent_el).append @starter_button.render().el
