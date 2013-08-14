class @ICRMClient.Widget.NotificationsController extends @ICRMClient.Base

  constructor: (options) ->
    @collection = options.collection
    @notification_url = window.ICRMClient.Assets.api_url + '/notifications/' + options.visitor.id
    @faye = options.faye
    @chanel = "/notifications/#{options.visitor.id}"

    (@faye.subscribe @chanel, @_notificationHandler, @).callback =>
      @get_unread()

    _id = 0

    window.ICRMClient.TestHelpers.SendTestNotificatoin = =>
      @_notificationHandler notification:
        id: _id++
        manager:
          avatar_url: 'http://lorempixel.com/32/32/cats/'
        subject: 'Subject'
        content: "Lorem Ipsum is http://ya.ru simply dummy text of the printing and typesetting industry. Lorem http://ya.ru Ipsum has been the industry's standard dummy text ever since the 1500s"

  _notificationHandler: (message) =>
    console.log JSON.stringify(message)
    @collection.add new ICRMClient.Notifications.NotificationModel(message.notification)

  get_unread: =>
    window.ICRMClient.Base::ajax
      url: @notification_url + '/get_unread'
      success: (response) =>
        console.log "recieved unread #{response.length} notifications"
        @collection.add (new  @collection.model(notification) for notification in response)


