class @ICRMClient.Chat.ChatController extends @ICRMClient.Base
  constructor: (visitor_id) ->
    @visitor_id = visitor_id

    @messages_collection = new ICRMClient.Chat.MessagesCollection()

    new ICRMClient.Chat.ContainerView
      collection: @messages_collection
      visitor_id: @visitor_id

    window.ICRMClient.faye.subscribe "/chat/#{visitor_id}", @_messageHandler

    _id = 0

    window.ICRMSendServerMessage = =>
      @_messageHandler
        method: 'create'
        message:
          visitor_id: @visitor_id
          id: _id++
          created_at: new Date()
          from_type: 'Manager'
          from_id: 123
          from:
            name: 'John Birman'
          content: 'Show must go on'

  _messageHandler: (msg) =>
    if msg.method == 'create'
      # Collection is smart to detect the existed message
      if msg.message.from_id == @from_id && msg.message.from_type == @from_type
        console.log "message from me"
      else
        @messages_collection.add msg.message
