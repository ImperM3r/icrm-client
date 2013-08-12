class ICRMClient.Notifications.NotificationView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_view']

  events:
    'click a.j-go-back': '_close'

  initialize: (options) ->
    @tab_view = options.tab_view

  render: ->
    @model.markRead()
    @$el.html @template @_presentation()
    @

  _presentation: =>
    presentation = @model.toJSON()
    _.extend presentation, window.ICRMClient.Helpers, @
    presentation

  _close: =>
    @tab_view.closeCurrentView()
    @remove()
