class @ICRMClient.NotificationController extends @ICRMClient.Backbone.View
  className: 'notifications bottom-right'

  initialize: (options) ->
    @faye = options.faye || window.ICRMClient.faye

    @faye.subscribe "/notifications/#{options.visitor.id}", @_notificationHandler

    window.ICRMClient.TestHelpers.SendTestNotificatoin= =>
      @_notificationHandler notification:
        id: 1
        manager:
          avatar_url: 'http://lorempixel.com/32/32/cats/'
        subject: 'Subject',
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"


  _notificationHandler: (message) =>
    console.log "Receive notifiction", JSON.stringify(message)

    noty = new window.ICRMClient.NotificationView
      controller: @
      notification: message.notification

    @$el.append noty.render().$el
