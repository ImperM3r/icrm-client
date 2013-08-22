class ICRMClient.Chat.ConversationController extends @ICRMClient.Base
  constructor: (options, callbacks) ->
    @_.extend @, ICRMClient.Backbone.Events

    @conversation = options.conversation
    @eb           = options.eb
    @faye         = options.faye
    @author       = options.author
    @collection   = options.collection

    @url     = "#{@assets.chat_api_url}#{@author.get('to_ident')}/conversations/#{@conversation.id}"
    channel = "/chat/#{@author.get('to_ident')}/conversations/#{@conversation.id}"

    conv_sub = @faye.subscribe channel, @_messageHandler
    conv_sub.callback =>
      @_channelReady options
      callbacks.success.call(@, @) if callbacks.success
    conv_sub.errback => callbacks.error.call() if callbacks.error

  _channelReady: (options) =>
      @message_observer = new ICRMClient.Chat.MessageObserver options
      @_sendOpen()
      @listenTo @eb, 'messages:history:get', =>
        since_id = if first = @collection.first() then first.get('id') else undefined
        @_getHistory since_id
      @listenTo @eb, 'window:hidden', @_sendClose
      console.log "conversation id: #{@conversation.id} established"

  _sendOpen: => @ajax url: @url + '/open'
  _sendClose: => @ajax url: @url + '/close'

  _messageHandler: (msg) =>
    switch msg.event
      when 'messages' then @_addMessages msg.messages
      when 'close' then @_closeConversation msg.message
      else console.log "Unknown message method: #{msg.method}"

  _closeConversation: (message) =>
    @collection.addServiceMsg message
    @message_observer.close()
    @stopListening()
    @trigger 'close'

  _addMessages: (messages) =>
    @_.each messages, (message) =>
      console.log "addMessages msg: #{JSON.stringify(message)}"
      if msg = @collection.get(message.id)
        msg.set message
      else
        @collection.add new @collection.model(message)

  _getHistory: (since_id) =>
    @ajax
      url: @url + '/messages'
      data: { since_id: since_id, count: window.ICRMClient.history_count }
      type: 'GET'
      success: (messages) =>
        @collection.add( new @collection.model message ) for message in messages by -1
        console.log "recieved last #{messages.length} messages"
