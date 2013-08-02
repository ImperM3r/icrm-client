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

    notifications_controller = new ICRMClient.Widget.NotificationsController visitor: visitor, faye: faye

    if window.ICRM_Settings.widget || ICRMClient.Utils.gup('convead_widget')
      @widget_controller = new ICRMClient.Widget.RootController
        visitor: visitor
        notifications: notifications_controller.collection
      #TODO run after dom ready
      @container.append @widget_controller.render().$el
