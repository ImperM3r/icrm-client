class ICRMClient.Notifications.NotificationTabView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_tab_view']

  header_class: 'notifications'
  tab_name: @.prototype.t 'widget.tab.notifications'
  id: 'convead_notifications_holder'

  disabled: ->
    @collection.length == 0

  initialize: (options) ->
    @parent_controller = options.parent_controller
    @list_view = new ICRMClient.Notifications.NotificationListView collection: @collection, tab_view: @

  render: ->
    @$el.html @template()
    @$('.notification-list').html @list_view.render().el
    @

  closeCurrentView: =>
    @$('.notification-list').show()

  showNotification: (model) =>
    notification = new ICRMClient.Notifications.NotificationView model: model, tab_view: @
    @$('.notification-list').hide()
    @$('.notification-container').html notification.render().el
    true
