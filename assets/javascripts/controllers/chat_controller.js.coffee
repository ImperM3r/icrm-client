class @ICRMClient.Controllers.ChatController extends @ICRMClient.Base

  constructor: (visitor_id) ->
    @drawChatStarter()
    @chat_subscription = window.ICRMClient.faye.subscribe "/chat/#{visitor_id}", @_messageHandler

    @messages_collection = new ICRMClient.Collections.Messages {}
    new ICRMClient.Views.MessagesView
      collection: @messages_collection
      model_view: ICRMClient.Views.MessageView
      el: 'ul.icrm-chat-messages-list'


    @$('input[name="icrm-client-message-submit"]').click =>
      @_composeMessage()

    _id = 0

    window.ICRMSendServerMessage = =>
      @_messageHandler message:
        id: _id++
        timestamp: new Date()
        sender: 'Freddy Mercury'
        content: 'Show must go on'

  drawChatStarter: =>
    @$rootNode.find('.starter').on 'click', @_showChat

  _showChat: =>
    true

  _composeMessage: =>
    @messages_collection.add
      timestamp: new Date()
      sender: '__client__'
      content: @$('input[name="icrm-client-message"]').val()

  _messageHandler: (message) =>
    @messages_collection.add message.message
    @log message
