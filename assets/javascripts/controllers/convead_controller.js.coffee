class @ICRMClient.ConveadController extends @ICRMClient.Base
  template: JST['root_template']

  constructor: (options) ->
    window.ICRMClient.app_key = window.ICRM_Settings.app_key
    delete window.ICRM_Settings.app_key

    window.ICRMClient.head = document.getElementsByTagName('head')[0]

    window.ICRMClient.Utils.loadStyle  @assets.css

    @el = @_createRootNode()
    @$el = @$ @el

    # TODO include faye_client into this script
    window.ICRMClient.Utils.loadScript @assets.faye_js, @_tryInitFaye

    @_runInformer()

  _createRootNode: =>
    # TODO rename icrm_chat to icrm_client
    root = @$ @template()

    @$('body').eq(0).append root

    # TODO Избавиться от глобалоной $rootNode
    # пусть каждый виджет сам себе делает нужные элементы
    window.ICRMClient.Base::$rootNode = root

    # TODO Перенести создание вьюх для Notification в NotificationView
    # и избавиться от глобальной $notifoicationNode
    window.ICRMClient.Base::$notificationsNode = root.find('.notifications')
    root

  _tryInitFaye: =>
    return unless @visitor_id

    @log 'init faye'

    window.ICRMClient.faye = new ICRMClient.FayeClient
      app_key: window.ICRMClient.app_key
      visitor: @informer_response.visitor

    if window.ICRM_Settings.chat
      @widget_controller = new ICRMClient.Widget.RootController visitor_id: @visitor_id
      @$el.append @widget_controller.render().$el

    @notification_controller = new window.ICRMClient.NotificationController @visitor_id

  _runInformer: =>
    return if @informer
    @log "Run _runInformer"

    @informer = new window.ICRMClient.InformerController (response) =>
      @informer_response = response
      @log "Informer response: #{response.toString()}"

      if !response || !response.visitor
        @log "Problem with visitor_id: #{response.data}"
      else
        @visitor_id = response.visitor.id

        @_tryInitFaye()
