class @ICRMClient.Controllers.ChatController extends @ICRMClient.Base

  constructor: (visitor_id) ->
    @el =
      $starter:      @$rootNode.find '.icrm_button_starter'
      $chat_holder:  @$rootNode.find '.chat_holder'
      messages_list: 'ul.icrm_chat_messages_list'
      $input_text:   @$rootNode.find 'textarea[name="icrm_message_text"]'
      $submit:       @$rootNode.find 'input[name="icrm_message_submit"]'

    @_showStarter()
    @chat_subscription = window.ICRMClient.faye.subscribe "/chat/#{visitor_id}", @_messageHandler

    @messages_collection = new ICRMClient.Collections.Messages()
    new ICRMClient.Views.MessagesView
      collection: @messages_collection
      model_view: ICRMClient.Views.MessageView
      el: @el.messages_list


    @el.$submit.click (event) =>
      @_composeMessage @el.$input_text.val()
      @el.$input_text.val('')
      false

    _id = 0

    window.ICRMSendServerMessage = =>
      @_messageHandler message:
        id: _id++
        timestamp: new Date()
        sender: 'Freddy Mercury'
        content: 'Show must go on'

  _showStarter: =>
    if window.ICRM_Settings.chat == true
      @el.$starter.show()
      @el.$starter.on 'click', @_showChat
      @el.$chat_holder.find('.icrm_chat_close').click @_closeChat

  _showChat: =>
    @el.$chat_holder.show()

  _closeChat: =>
    @el.$chat_holder.hide()

  _composeMessage: (content) =>
    @messages_collection.add
      timestamp: new Date()
      sender: '__client__'
      content: content

  _messageHandler: (message) =>
    @messages_collection.add message.message
    @log message
