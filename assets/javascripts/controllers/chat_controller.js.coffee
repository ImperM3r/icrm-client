class @ICRMClient.Controllers.ChatController extends @ICRMClient.Base
  messages_url: window.ICRMClient.Assets.api_url + 'chat/messages'

  constructor: (visitor_id) ->
    @el =
      $starter:      @$rootNode.find '.icrm_button_starter'
      $chat_holder:  @$rootNode.find '.chat_holder'
      messages_list: 'ul.icrm_chat_messages_list'
      $input_text:   @$rootNode.find 'textarea[name="icrm_message_text"]'
      $submit:       @$rootNode.find 'input[name="icrm_message_submit"]'

    @_showStarter()

    @visitor_id = visitor_id
    # @drawChatStarter()

    @from_type = 'Visitor'
    @from_id = visitor_id

    @messages_collection = new ICRMClient.Collections.Messages()

    @messages_view = new ICRMClient.Views.MessagesView
      collection: @messages_collection
      el: @el.messages_list

    window.ICRMClient.faye.subscribe "/chat/#{visitor_id}", @_messageHandler

    @el.$submit.click (event) =>
      @_postMessage @el.$input_text.val()
      @el.$input_text.val('')
      false

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

  _showStarter: =>
    if window.ICRM_Settings.chat == true
      @el.$starter.show()
      @el.$starter.on 'click', @_showChat
      @el.$chat_holder.find('.icrm_chat_close').click @_closeChat

  _showChat: =>
    @el.$chat_holder.show()

  _closeChat: =>
    @el.$chat_holder.hide()

  _postMessage: (content) =>
    message = new window.ICRMClient.Models.Message
      visitor_id: @visitor_id
      from_type: @from_type
      from_id: @from_id
      content: content

    @ajax
      url: @messages_url
      data: message.attributes
      success: (message) =>
        @messages_collection.add message

  _messageHandler: (message) =>
    if message.method == 'create'
      # Collection is smart to detect the existed message
      @messages_collection.add message.message
