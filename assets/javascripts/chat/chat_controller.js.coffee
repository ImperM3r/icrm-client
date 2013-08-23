class ICRMClient.Chat.ChatController extends @ICRMClient.Base
  constructor: (options) ->
    @_.extend @, ICRMClient.Backbone.Events

    @eb                = options.eb
    @collection        = options.collection
    @author            = options.author
    @faye              = options.faye
    @recipient_ident   = options.recipient_ident

    @url     = "#{@assets.chat_api_url}#{@author.get('to_ident')}"
    channel  = "/chat/#{@author.get('to_ident')}"

    @serv_sub = @faye.subscribe channel, @_serviceHandler
    @serv_sub.callback => @ajax url: @url + '/online'

    @listenTo @eb, 'conversation:status', =>
      @eb.trigger if @conversation_controller then 'conversation:opened' else 'conversation:closed'

    @listenTo @eb, 'window:shown standalone:shown', =>
      return if @conversation_controller
      @ajax
        url: @url + '/call'
        data: { recipient: options.recipient_ident }
        error: (response) =>
          unless json = response.responseJSON
            json = JSON.parse response.responseText
          @collection.addServiceMsg json.message

    @listenTo @eb, 'standalone:close', =>
      @stopListening()
      @serv_sub.cancel()

  _serviceHandler: (msg) =>
    switch msg.event
      when 'call' then @_newConversation msg.conversation
      else console.log msg

  _newConversation: (conversation) =>
    return if @conversation_controller or (@recipient_ident and conversation.visitor.to_ident != @recipient_ident)
    options = eb: @eb, conversation: conversation, collection: @collection, author: @author, faye: @faye
    @conversation_controller = new ICRMClient.Chat.ConversationController options,
      success: (controller) =>
        @eb.trigger 'message:show conversation:opened'
        @listenTo controller, 'close', @_closeConversation
        console.log "new conversation initialized #{JSON.stringify(conversation)}"
      error: @_closeConversation

  _closeConversation: =>
    delete @conversation_controller
    @eb.trigger 'conversation:closed'
