class @ICRMClient.RootController extends @ICRMClient.Base
  isLoaded = false

  constructor: (options) ->
    window.ICRMClient.head = document.getElementsByTagName('head')[0]

    window.ICRMClient.Utils.loadStyle  @assets.css

    # TODO include faye_client into this script
    window.ICRMClient.Utils.loadScript @assets.faye_js, @_tryInitFaye

    @_createRootNode()
    @_runInformer()

  _createRootNode: =>
    # TODO rename icrm_chat to icrm_client
    root =  @$('
      <div id="icrm_chat">
        <div class="starter"></div>
        <div class="notifications bottom-right"></div>
      </div>
    ')

    @$('body').eq(0).append root
    window.ICRMClient.Base::$rootNode = root
    window.ICRMClient.Base::$notificationsNode = root.find('.notifications')

  _tryInitFaye: =>
    @log 'try init faye'
    return unless Faye? and @visitor_id

    @log 'init faye'
    # We can init faye if here is initializer @visitor and
    window.ICRMClient.faye = new Faye.Client @assets.faye_url
    window.ICRMClient.faye.setHeader 'ICRM-Visitor', @visitor_id
    # window.ICRMClient.faye.addExtension window.ICRMClient.FayeLogger

    @chat_controller = new window.ICRMClient.Controllers.ChatController @visitor_id
    @notification_controller = new window.ICRMClient.Controllers.NotificationController @visitor_id

  _runInformer: =>
    @log "Try to _runInformer"
    return if @informer
    @log "Run _runInformer"

    @informer = new window.ICRMClient.Controllers.Informer (response) =>
      #@visitor_id = parseInt JSON.parse(response.data).visitor_id
      @visitor_id = response.visitor_id

      if isNaN(@visitor_id) # unless visitor_id is a number
        @log "Problem with visitor_id: #{response.data}"
      else
        @log "Get visitor_id: #{@visitor_id}"

        @_tryInitFaye()
