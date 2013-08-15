class ICRMClient.Notifications.NotificationTabView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_tab_view']

  header_class: 'notifications'
  tab_name: @.prototype.t 'widget.tab.notifications'
  id: 'convead_notifications_holder'

  disabled: ->
    @collection.length == 0

  initialize: (options) ->
    @list_view = new ICRMClient.Notifications.NotificationListView collection: @collection, tab_view: @

  render: ->
    @$el.html @template()
    @$('#convead-notifications-list').html @list_view.render().el
    @

  closeCurrentView: =>
    @$('#convead-notifications-list').show()

  showNotification: (model) =>
    notification = new ICRMClient.Notifications.NotificationView model: model, tab_view: @
    @$('#convead-notifications-list').hide()
    @$('#convead-notifications-container').html notification.render().el
    true

  show: ->
    @$el.show()

  hide: ->
    @$el.hide()
