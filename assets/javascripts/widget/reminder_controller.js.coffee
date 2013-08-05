class @ICRMClient.Widget.ReminderController extends @ICRMClient.Base

  constructor: (options) ->
    @notifications = options.notification_collection
    @widget        = options.widget

    setInterval @_reminder, 5 * 1000

  _reminder: =>
    if unread_notification = @notifications.firstUnread()
      @widget.showNotification unread_notification
