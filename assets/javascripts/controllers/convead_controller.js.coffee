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
    root = @$ @template()

    @$('body').eq(0).append root

    # TODO Перенести создание вьюх для Notification в NotificationView
    # и избавиться от глобальной $notifoicationNode
    window.ICRMClient.Base::$notificationsNode = root.find('.notifications')
    root

  _tryInitFaye: =>
    return unless @visitor

    @log 'init faye'

    window.ICRMClient.faye = new ICRMClient.FayeClient
      app_key: window.ICRMClient.app_key
      visitor: @informer_response.visitor

    if window.ICRM_Settings.widget || ICRMClient.Utils.gup('convead_widget')
      @widget_controller = new ICRMClient.Widget.RootController visitor: @visitor
      @$el.append @widget_controller.render().$el

    @notification_controller = new window.ICRMClient.NotificationController @visitor

  _runInformer: =>
    return if @informer
    @log "Run _runInformer"

    @informer = new window.ICRMClient.InformerController (response) =>
      @informer_response = response
      @log "Informer response: #{response.toString()}"

      if !response || !response.visitor
        @log "Bad response #{response.data}"
      else
        @visitor = response.visitor
        @visitor.type = 'Visitor'
        window.ICRMClient.visitor = @visitor


        @_tryInitFaye()
