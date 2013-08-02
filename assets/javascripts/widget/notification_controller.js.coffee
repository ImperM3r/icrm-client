class @ICRMClient.Widget.NotificationController extends @ICRMClient.Base

  constructor: (options) ->
    @collection = new ICRMClient.Notifications.NotificationsCollection()
    options.faye.subscribe "/notifications/#{options.visitor.id}", @_notificationHandler

    _id = 0

    window.ICRMClient.TestHelpers.SendTestNotificatoin = =>
      @_notificationHandler notification:
        id: _id++
        manager:
          avatar_url: 'http://lorempixel.com/32/32/cats/'
        subject: 'Subject'
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"

  _notificationHandler: (message) =>
    console.log JSON.stringify(message)
    @collection.add new ICRMClient.Notifications.NotificationModel(message.notification)
