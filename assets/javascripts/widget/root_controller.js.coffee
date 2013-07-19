class @ICRMClient.Widget.RootController extends @ICRMClient.Backbone.View
  className: 'convead_client-widget-root'

  # Input parameters:
  # visitor_id
  initialize: (options) ->
    @window         = new ICRMClient.Widget.WindowView visitor_id: options.visitor_id

    @starter_button = new ICRMClient.Widget.StarterButtonView
      window: @window

  render: ->
    @$el.append @window.render().$el
    @$el.append @starter_button.render().$el

    @
