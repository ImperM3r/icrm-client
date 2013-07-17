class @ICRMClient.RootController extends @ICRMClient.Base
  template: JST['root_template']

  constructor: (options) ->
    window.ICRMClient.app_key = window.ICRM_Settings.app_key
    delete window.ICRM_Settings.app_key

    window.ICRMClient.head = document.getElementsByTagName('head')[0]

    window.ICRMClient.Utils.loadStyle  @assets.css

    @el = @_createRootNode()

    # TODO include faye_client into this script
    window.ICRMClient.Utils.loadScript @assets.faye_js, @_tryInitFaye

    @_runInformer()

  _createRootNode: =>
    # TODO rename icrm_chat to icrm_client
    root = @$ @template()

    @$('body').eq(0).append root
    window.ICRMClient.Base::$rootNode = root
    window.ICRMClient.Base::$notificationsNode = root.find('.notifications')
    root

  _tryInitFaye: =>
    @log 'try init faye'
    return unless Faye? and @visitor_id

    @log 'init faye'
    # We can init faye if here is initializer @visitor and
    window.ICRMClient.faye = new Faye.Client @assets.faye_url
    window.ICRMClient.faye.setHeader 'ICRM-Visitor', @visitor_id
    # window.ICRMClient.faye.addExtension window.ICRMClient.FayeLogger

    @widget_controller = new ICRMClient.Widget.WindowController
      visitor_id: @visitor_id
      parent_el: @el
      visible: window.ICRM_Settings.chat == true

    @notification_controller = new window.ICRMClient.NotificationController @visitor_id

  _runInformer: =>
    @log "Try to _runInformer"
    return if @informer
    @log "Run _runInformer"

    @informer = new window.ICRMClient.InformerController (response) =>
      #@visitor_id = parseInt JSON.parse(response.data).visitor_id
      @visitor_id = response.visitor_id

      if isNaN(@visitor_id) # unless visitor_id is a number
        @log "Problem with visitor_id: #{response.data}"
      else
        @log "Get visitor_id: #{@visitor_id}"

        @_tryInitFaye()
