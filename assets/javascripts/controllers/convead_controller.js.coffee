class @ICRMClient.ConveadController extends @ICRMClient.Base
  constructor: (options) ->
    @container = options.container

    window.ICRMClient.app_key = window.ICRM_Settings.app_key
    delete window.ICRM_Settings.app_key

    if options.faye
      window.ICRMClient.faye = faye
    else
      window.ICRMClient.Utils.loadScript @assets.faye_js, @start_visitor

  start_visitor: =>
    return unless visitor = window.ICRMClient.visitor
    @debug "Start visitor #{visitor.id}"


    if window.ICRMClient.faye
      @error 'Faye is already defined'

    window.ICRMClient.faye = faye = new ICRMClient.FayeClient
      app_key: window.ICRMClient.app_key
      visitor: visitor

    notifications            = new ICRMClient.Notifications.NotificationsCollection()
    notifications_controller = new ICRMClient.Widget.NotificationsController collection: notifications, visitor: visitor, faye: faye

    sender                   = new ICRMClient.Chat.Chatter visitor
    messages                 = new ICRMClient.Chat.MessagesCollection()
    chat_controller          = new ICRMClient.Widget.ChatController collection: messages, sender: sender, faye: faye

    new ICRMClient.Chat.MessageObserver collection: messages, sender: sender

    widget_controller = new ICRMClient.Widget.RootController
      visitor:       visitor
      notifications: notifications
      messages:      messages

    #TODO run after dom ready
    @container.append widget_controller.render().$el

    new ICRMClient.Notifications.NotificationObserver collection: notifications, widget: widget_controller
    new ICRMClient.Widget.ReminderController
      notification_collection: notifications
      widget:                  widget_controller
