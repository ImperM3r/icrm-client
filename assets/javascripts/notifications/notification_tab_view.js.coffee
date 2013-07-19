class ICRMClient.Notifications.NotificationTabView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_tab_view']

  tabName: 'div'
  id: 'convead_notifications_holder'

  tab_name: 'Notifications'

  render: ->
    @$el.html @template()
    @
