class @ICRMClient.Controllers.ChatController

  constructor: (visitor_id) ->
    @isLoaded = false
    @data =
      app_key: window.ICRMClient.app_key
      visitor_id: visitor_id
    @drawChatStarter()
    window.ICRMClient.faye.subscribe "/chat/#{visitor_id}", @messageHandler

  drawChatStarter: =>
    @$rootNode.find('.starter').on 'click', @drawChat

  messageHandler: (message) =>
    @log message

  drawChat: =>
    return unless window.ICRMClient.xhr? and @$? and !@isLoaded

    window.ICRMClient.xhr.request
      url: @assets.chat_url
      data: @data
      headers: { "Content-Type" : "application/x-www-form-urlencoded" }
    , (response) => #success function
      @isLoaded = true
      @$rootNode.append response.data
    , (response) => #error function
      @log response
