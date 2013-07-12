class @ICRMClient.Controllers.ChatController extends @ICRMClient.Base

  constructor: (data) ->
    return
    @xhr = @faye = @jq = null
    @isLoaded = @isSubscribed = false
    @data = data
    @faye.subscribe "/chat/#{@visitor_id}", @messageHandler

  drawChatStarter: ->
    jq = window.ICRMClient.jQuery
    jq('#icrm_chat .starter').on 'click', @$.proxy(window.ICRMClient.Chat, 'drawChat')


  log: (message) ->
    console.log message

  messageHandler: (message) =>
    @log message

  drawChat: =>
    @jq ||= window.ICRMClient.jQuery
    return unless @xhr? and @jq? and !@isLoaded

    @xhr.request
      url: @assets.system_chat_url
      data: @data
      headers: { "Content-Type" : "application/x-www-form-urlencoded" }
    , (response) => #success function
      @isLoaded = true
      @jq('#icrm_chat').eq(0).append response.data
    , (response) => #error function
      @log response

  subscribe: ->
    @xhr ||= window.ICRMClient.xhr
    return unless @xhr? and !@isSubscribed

    @xhr.request
      url: @assets.system_logger_url
      data: @data
      headers: { "Content-Type" : "application/x-www-form-urlencoded" }
    , (response) => #success function
      @faye = new Faye.Client @assets.faye_url

      visitor_id = parseInt JSON.parse(response.data).visitor_id
      if isNaN(visitor_id) # unless visitor_id is a number
        @log "Problem with visitor_id"
      else # visitor_id is a number
        @isSubscribed = true
        @visitor_id = @data['user_data[visitor_id]'] = visitor_id
        @log "Get visitor_id: #{@visitor_id}"

        @faye.subscribe "/notifications/#{@visitor_id}", @notificationHandler
        @faye.subscribe "/chat/#{@visitor_id}", @messageHandler

    , (response) => #error function
      @log response
