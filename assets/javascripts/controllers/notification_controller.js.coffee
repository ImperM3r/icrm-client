#= require models/notification

class @ICRMClient.Controllers.NotificationController extends @ICRMClient.Base
  constructor: (visitor_id) ->
    unless window.ICRMClient.jQuery?
      console.error "Can't initalize NotificationController"
      return

    window.ICRMClient.faye.subscribe "/notifications/#{visitor_id}", @_notificationHandler

    window.ICRMSendTestNotify= =>
      @_notificationHandler notification:
        subject: 'Subject',
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"

  _notificationHandler: (message) =>
    console.log "Receive notifiction #{message}"

    noty = new window.ICRMClient.Models.Notification message.notification
    noty.show()