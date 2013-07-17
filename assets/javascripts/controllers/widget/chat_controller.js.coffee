class @ICRMClient.Chat.ChatController extends @ICRMClient.Base
  messages_url: window.ICRMClient.Assets.api_url + 'chat/messages'

  constructor: (visitor_id) ->
    @visitor_id = visitor_id

    @from_type = 'Visitor'
    @from_id = visitor_id

    @messages_collection = new ICRMClient.Chat.MessagesCollection()

    @messages_view = new ICRMClient.Chat.MessagesView
      collection: @messages_collection

    @form = new ICRMClient.Chat.FormView
      collection: @messages_collection

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

  _postMessage: (content) =>
    message = new window.ICRMClient.Chat.MessageModel
      visitor_id: @visitor_id
      from_type: @from_type
      from_id: @from_id
      created_at: 'sending..'
      content: content

    @messages_collection.add message

    @ajax
      url: @messages_url
      data: message.attributes
      success: (response) =>
        message.set response

  _messageHandler: (msg) =>
    if msg.method == 'create'
      # Collection is smart to detect the existed message
      if msg.message.from_id == @from_id && msg.message.from_type == @from_type
        console.log "message from me"
      else
        @messages_collection.add msg.message
