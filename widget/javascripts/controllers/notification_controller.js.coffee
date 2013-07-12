#= require ../models/notification

class @ICRMClient.Controllers.NotificationController extends @ICRMClient.Base
  constructor: (visitor_id) ->
    unless window.ICRMClient.jQuery?
      console.error "Can't initalize NotificationController"
      return

    window.ICRMClient.faye.subscribe "/notifications/#{visitor_id}", @_notificationHandler

  _notificationHandler: (message) =>
    console.log "Receive notifiction #{message}"

    noty = new window.ICRMClient.Models.Notification message.notification
    noty.show()
