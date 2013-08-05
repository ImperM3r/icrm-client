class ICRMClient.Notifications.NotificationsCollection extends @ICRMClient.Backbone.Collection
  model: ICRMClient.Notifications.NotificationModel

  unreadCount: =>
    @length - @where( read: true ).length

  firstUnread: =>
    @find (model) -> model.get('read') != true
