class @ICRMClient.Widget.ChatController extends @ICRMClient.Base

  constructor: (options) ->
    _.extend @, ICRMClient.Backbone.Events

    @eb               = window.ICRMClient.EventBroadcaster
    @collection       = options.collection
    @sender           = options.sender
    @conversation_id  = options.sender.get('id')
    @conversation_url = @assets.api_url + 'chat/conversation/' + @conversation_id
    @faye             = options.faye
    @channel          = "/conversations/#{@conversation_id}"

    @listenTo @eb, 'messages:history:get', (e) =>
      since_id = if first = @collection.first() then first.get('id') else undefined
      @_getHistory since_id

    # callback for retrieve unread msgs only when channel is up and ready
    (@faye.subscribe @channel, @_messageHandler).callback => @_getHistory()

  _messageHandler: (msg) ->
    switch msg.method
      when 'create' then @_createMessage msg.message
      when 'modify' then @_modifyMessage msg.message
      else console.log "Unknown message method: #{msg.method}"

  _createMessage: (m) =>
    # Collection is smart to detect the existed message
    if m.sender.id == @sender.get('id') && m.sender.type == @sender.get('type')
      console.log "Got retranslated message"
    else
      @parent_controller.show()
      message = new @collection.model m
      @collection.add message

  _modifyMessage: (m) =>
    if message = @collection.get(m.id)
      console.log message
      message.set m
    else
      console.log "message does not exist in collection, id: #{m.id}"

  _makeCall: (model) =>
    if !@call_sent and model.get('sender').type == 'Visitor'
      @call_sent = true
      @faye.client.publish @faye.org_path + @channel,
        method: 'call',
        conversation_id: @sender.get('id')

  _getHistory: (since_id) ->
    @ajax
      url: @conversation_url + '/messages'
      data: { since_id: since_id, count: window.ICRMClient.history_count }
      success: (response) =>
        console.log "recieved last #{response.length} messages"
        @collection.add( new @collection.model message ) for message in response
