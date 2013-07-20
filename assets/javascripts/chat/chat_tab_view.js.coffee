class ICRMClient.Chat.ChatTabView extends @ICRMClient.Backbone.View
  tagName: 'div'
  id: 'convead_chat_holder'
  tab_name: 'Conversation'

  initialize: (options) ->
    @parent_controller     = options.parent_controller
    @sender          = options.sender
    @conversation_id = options.conversation_id

    @collection      = new ICRMClient.Chat.MessagesCollection

    @form_view = new ICRMClient.Chat.FormView
      conversation_id: @conversation_id
      collection:      @collection
      sender:          @sender

    @messages_view = new ICRMClient.Chat.MessagesView
      collection: @collection

    window.ICRMClient.faye.subscribe "/conversations/#{@conversation_id}", @_messageHandler, @

    _id = 0

    window.ICRMClient.TestHelpers.SendChatMessage = =>
      @_messageHandler
        method: 'create'
        message:
          id:         _id++
          conversation_id: @conversation_id
          sender:
            type: 'Manager'
            id:   0
            name: 'John Silver'
          recipient: @sender
          created_at: new Date()
          content:    'Show must go on'

  render: ->
    @$el.append @messages_view.render().$el
    @$el.append @form_view.render().$el
    @

  _messageHandler: (msg) ->
    if msg.method == 'create'
      # Collection is smart to detect the existed message
      if msg.message.sender.id == @sender.id && msg.message.sender.type == @sender.type
        console.log "Got retranslated message"
      else
        @parent_controller.show()
        message = new ICRMClient.Chat.Message msg.message
        @collection.add message
