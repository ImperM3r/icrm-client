class @ICRMClient.Widget.RootController extends @ICRMClient.Backbone.View
  className: 'convead_client-widget-root'

  initialize: (options) ->
    @window         = new ICRMClient.Widget.WindowView
      eb:            options.eb
      visitor:       options.visitor
      notifications: options.notifications
      messages:      options.messages

    @starter_button = new ICRMClient.Widget.StarterButtonView
      window: @window

  events:
    'click a' : '_linkHandler'

  render: ->
    @$el.append @window.render().$el
    @$el.append @starter_button.render().$el
    @

  showNotification: (model) ->
    @window.showNotification model

  showMessage: ->
    @window.showMessage()

  _linkHandler: (e) =>
    unless e.target.getAttribute('data-link-external') == 'true'
      e.preventDefault()
