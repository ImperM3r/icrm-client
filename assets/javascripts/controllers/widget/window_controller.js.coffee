class @ICRMClient.Widget.WindowController extends @ICRMClient.Base

  constructor: (options) ->
    new ICRMClient.Chat.ChatController options.visitor_id

    @window         = new ICRMClient.Widget.WindowView()
    @starter_button = new ICRMClient.Widget.StarterButtonView
      window: @window

    @visible = options.visible
    @parent_el = options.parent_el
    @_render()

  _render: ->
    if @visible
      @$(@parent_el).append @window.render().el
      @$(@parent_el).append @starter_button.render().el
