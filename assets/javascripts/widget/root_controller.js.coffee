class @ICRMClient.Widget.RootController extends @ICRMClient.Backbone.View
  className: 'convead_client-widget-root'

  initialize: (options) ->
    @window         = new ICRMClient.Widget.WindowView
      visitor: options.visitor
      notifications: options.notifications

    @starter_button = new ICRMClient.Widget.StarterButtonView
      window: @window

  render: ->
    @$el.append @window.render().$el
    @$el.append @starter_button.render().$el

    @
