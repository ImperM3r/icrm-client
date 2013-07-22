class ICRMClient.Chat.ChatTabView extends @ICRMClient.Backbone.View
  tagName: 'div'
  className: 'convead_chat_holder'
  tab_name: 'Conversation'

  initialize: (options) ->
    @parent_controller     = options.parent_controller
    @sender          = options.sender
    @conversation_id = options.conversation_id
    @faye            = options.faye

    @message_api_url = window.ICRMClient.Assets.api_url + 'chat/conversation/' + @conversation_id + '/message/'

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

  _create_message: (m) =>
    # Collection is smart to detect the existed message
    if m.sender.id == @sender.get('id') && m.sender.type == @sender.get('type')
      console.debug "Got retranslated message"
    else
      @parent_controller.show()
      message = new ICRMClient.Chat.Message m
      @collection.add message
      @_mark_read_message message

  _mark_read_message: (message) =>
    window.ICRMClient.Base::ajax
      url: @message_api_url + message.id + '/mark_read'
      data: message.attributes
      success: (response) ->
        console.debug "message id:#{message.id} | read status: #{JSON.parse(response).status}"

  _modify_message: (m) =>
    if message = @collection.get(m.id)
      console.debug message
      message.set m
    else
      console.error "message does not exist in collection, id: #{m.id}"

  _messageHandler: (msg) ->
    switch msg.method
      when 'create' then @_create_message msg.message
      when 'modify' then @_modify_message msg.message
      else console.error "Unknown message method: #{msg.method}"

