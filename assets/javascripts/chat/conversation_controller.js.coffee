class ICRMClient.Chat.ConversationController extends @ICRMClient.Base

  constructor: (options, callbacks) ->
    _.extend @, ICRMClient.Backbone.Events

    @conversation = options.conversation
    @eb           = options.eb
    @faye         = options.faye
    @sender       = options.sender
    @collection   = options.collection

    @conversation_url     = "#{@assets.api_url}chat/conversation/#{@conversation.id}"
    @conversation_channel = "/conversations/#{@conversation.id}"

    conv_sub = @faye.subscribe @conversation_channel, @_messageHandler
    conv_sub.callback =>
      console.log "conversation id: #{@conversation.id} established"
      @_getHistory()
      @listenTo @eb, 'messages:history:get', (e) =>
        since_id = if first = @collection.first() then first.get('id') else undefined
        @_getHistory since_id
      callbacks.success.call() if callbacks.success

    conv_sub.errback => callbacks.error.call() if callbacks.error

  _messageHandler: (msg) =>
    switch msg.method
      when 'create' then @_createMessage msg.message
      when 'modify' then @_modifyMessage msg.message
      else console.log "Unknown message method: #{msg.method}"

  _createMessage: (m) =>
    # Collection is smart to detect the existed message
    if m.sender.id == @sender.get('id') && m.sender.type == @sender.get('type')
      console.log "Got retranslated message"
    else
      @collection.add new @collection.model(m)

  _modifyMessage: (m) =>
    if message = @collection.get(m.id)
      console.log message
      message.set m
    else
      console.log "message does not exist in collection, id: #{m.id}"

  _getHistory: (since_id) ->
    @ajax
      url: @conversation_url + '/messages'
      data: { since_id: since_id, count: window.ICRMClient.history_count }
      success: (response) =>
        console.log "recieved last #{response.length} messages"
        @collection.add( new @collection.model message ) for message in response by -1
