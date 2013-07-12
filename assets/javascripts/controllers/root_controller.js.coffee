class @ICRMClient.RootController extends @ICRMClient.Base
  isLoaded = false

  constructor: (options) ->

    window.ICRMClient.head = document.getElementsByTagName('head')[0]

    window.ICRMClient.Utils.preparejQuery =>

      window.ICRMClient.Utils.loadStyle  @assets.css
      window.ICRMClient.Utils.loadScript @assets.easyXDM, @_scriptOnLoad
      window.ICRMClient.Utils.loadScript @assets.json2,   @_scriptOnLoad unless JSON?
      window.ICRMClient.Utils.loadScript @assets.faye_js, @_scriptOnLoad

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

  _scriptOnLoad: =>
    @log "Script On Load"
    return unless !isLoaded and easyXDM? and JSON? and Faye?
    isLoaded = true

    @log "Setup XHR"

    window.ICRMClient.xhr = new easyXDM.Rpc
      remote:       @assets.remote
      swf:          @assets.swf
      remoteHelper: @assets.remoteHelper
      onReady:      =>
        @_runInformer()

    , remote: { request: {} }

  _runInformer: =>
    @log "Run Informer"
    @informer = new window.ICRMClient.Controllers.Informer (response) =>
      @visitor_id = parseInt JSON.parse(response.data).visitor_id

      if isNaN(@visitor_id) # unless visitor_id is a number
        @log "Problem with visitor_id: #{response.data}"
      else
        @log "Get visitor_id: #{@visitor_id}"

        window.ICRMClient.faye = new Faye.Client @assets.faye_url
        window.ICRMClient.faye.setHeader 'ICRM-Visitor', @visitor_id
        window.ICRMClient.faye.addExtension window.ICRMClient.FayeLogger

        @chat_controller = new window.ICRMClient.Controllers.ChatController @visitor_id
        @notification_controller = new window.ICRMClient.Controllers.NotificationController @visitor_id

