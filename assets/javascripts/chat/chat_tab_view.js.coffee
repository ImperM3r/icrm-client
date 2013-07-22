class ICRMClient.Chat.ChatTabView extends @ICRMClient.Backbone.View
  tagName: 'div'
  className: 'convead_chat_holder'
  tab_name: 'Conversation'

  initialize: (options) ->
    @parent_controller     = options.parent_controller
    @sender          = options.sender
    @conversation_id = options.conversation_id
    @faye            = options.faye

    @confirm_url = window.ICRMClient.Assets.api_url + 'chat/conversation/' + @conversation_id + '/confirm/'

    @collection      = new ICRMClient.Chat.MessagesCollection

    @form_view = new ICRMClient.Chat.FormView
      conversation_id: @conversation_id
      collection:      @collection
      sender:          @sender
      ajax:            options.ajax

    @messages_view = new ICRMClient.Chat.MessagesView
      collection: @collection

    @faye.subscribe "/conversations/#{@conversation_id}", @_messageHandler, @

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
    switch msg.method
      when 'create'
        # Collection is smart to detect the existed message
        if msg.message.sender.id == @sender.get('id') && msg.message.sender.type == @sender.get('type')
          console.debug "Got retranslated message"
        else
          @parent_controller.show()
          message = new ICRMClient.Chat.Message msg.message
          @collection.add message

          window.ICRMClient.Base::ajax
            url: @confirm_url + message.id
            data: message.attributes
            success: (response) ->
              r = JSON.parse(response)
              console.debug "message id:#{message.id} | read status: #{r.status}"

      when 'update'
        if message = @collection.get(msg.message.id)
          console.debug msg
          message.set msg.message
        else
          console.error "message does not exist in collection, id: #{msg.message.id}"
