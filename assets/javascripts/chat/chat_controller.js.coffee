class ICRMClient.Chat.ChatController extends @ICRMClient.Base
  constructor: (options) ->
    @_.extend @, ICRMClient.Backbone.Events

    @eb                = options.eb
    @collection        = options.collection
    @sender            = options.sender
    @faye              = options.faye

    @url     = "#{@assets.chat_api_url}#{@sender.get('to_ident')}"
    channel  = "/chat/#{@sender.get('to_ident')}"

    serv_sub = @faye.subscribe channel, @_serviceHandler
    serv_sub.callback => @ajax url: @url + '/online'

    @listenTo @eb, 'window:shown standalone:shown', =>
      return if @conversation_controller
      @ajax
        url: @url + '/call'
        data: { recipient: options.recipient_ident }
        error: (response) => @collection.addServiceMsg response.message

  _serviceHandler: (msg) =>
    switch msg.event
      when 'call' then @_newConversation msg.conversation
      else console.log msg

  _newConversation: (conversation) =>
    return if @conversation_controller
    options = eb: @eb, conversation: conversation, collection: @collection, sender: @sender, faye: @faye
    @conversation_controller = new ICRMClient.Chat.ConversationController options,
      success: =>
        @eb.trigger 'message:show'
        @listenTo @conversation_controller, 'close', @_closeConversation
        console.log "new conversation initialized #{JSON.stringify(conversation)}"
      error: @_closeConversation

  _closeConversation: => delete @conversation_controller
