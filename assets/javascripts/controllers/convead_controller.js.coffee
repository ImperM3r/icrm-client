class @ICRMClient.ConveadController extends @ICRMClient.Base
  template: JST['convead_client_container']

  constructor: (options) ->
    window.ICRMClient.app_key = window.ICRM_Settings.app_key
    delete window.ICRM_Settings.app_key

    window.ICRMClient.head = document.getElementsByTagName('head')[0]

    window.ICRMClient.Utils.loadStyle  @assets.css

    @el = @_createRootNode()
    @$el = @$ @el

    # TODO include faye_client into this script
    window.ICRMClient.Utils.loadScript @assets.faye_js, @start_visitor

  _createRootNode: =>
    root = @$ @template()

    @$('body').eq(0).append root

    # TODO Перенести создание вьюх для Notification в NotificationView
    # и избавиться от глобальной $notifoicationNode
    window.ICRMClient.Base::$notificationsNode = root.find('.notifications')
    root

  start_visitor: =>
    return unless visitor = window.ICRMClient.visitor
    @debug 'Start visitor'

    window.ICRMClient.faye = new ICRMClient.FayeClient
      app_key: window.ICRMClient.app_key
      visitor: visitor

    if window.ICRM_Settings.widget || ICRMClient.Utils.gup('convead_widget')
      @widget_controller = new ICRMClient.Widget.RootController visitor: visitor
      @$el.append @widget_controller.render().$el

    @notification_controller = new window.ICRMClient.NotificationController visitor
