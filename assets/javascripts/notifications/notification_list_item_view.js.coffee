class ICRMClient.Notifications.NotificationListItemView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_list_item_view']

  tagName: 'li'
  className: 'popup-section'

  initialize: (options) ->
    @tab_view = options.tab_view
    @notification_view = new ICRMClient.Notifications.NotificationView model: @model, tab_view: @tab_view
    @tab_view.activateTab()
    @_showNotification()

  events:
    'click a.open' : '_showNotification'

  render: ->
    @$el.html(@template @model.toJSON()).fadeIn(400)
    @

  _showNotification: ->
    @tab_view.showView @notification_view
