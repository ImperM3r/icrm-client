class ICRMClient.Notifications.NotificationListItemView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_list_item_view']

  tagName: 'li'
  attributes: ->
    class: 'popup-section notification-' + if @model.get('read') then 'read' else 'unread'

  initialize: (options) ->
    @tab_view = options.tab_view
    @notification_view = new ICRMClient.Notifications.NotificationView model: @model, tab_view: @tab_view
    @tab_view.activateTab().showView @notification_view

    @listenTo @model, 'change', @render

  events:
    'click a.open' : '_showNotification'

  render: ->
    @$el.html(@template @model.toJSON()).fadeIn(400)
    @$el.attr 'class', @attributes().class
    @

  _showNotification: ->
    @tab_view.showView @notification_view
