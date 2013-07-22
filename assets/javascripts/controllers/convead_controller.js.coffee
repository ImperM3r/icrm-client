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
    @debug 'Start visitor'

    if window.ICRMClient.faye
      @error 'Faye is already defined'

    window.ICRMClient.faye = new ICRMClient.FayeClient
      app_key: window.ICRMClient.app_key
      visitor: visitor

    if window.ICRM_Settings.widget || ICRMClient.Utils.gup('convead_widget')
      @widget_controller = new ICRMClient.Widget.RootController visitor: visitor
      @container.append @widget_controller.render().$el

    @notification_controller = new window.ICRMClient.NotificationController visitor: visitor
    @container.append @notification_controller.render().$el
