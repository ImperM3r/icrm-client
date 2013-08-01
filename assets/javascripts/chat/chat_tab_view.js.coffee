class ICRMClient.Chat.ChatTabView extends @ICRMClient.Backbone.View
  tagName: 'div'
  className: 'convead_chat_holder'
  tab_name: 'Conversation'

  initialize: (options) ->
    @parent_controller     = options.parent_controller
    @sender          = options.sender
    @conversation_id = options.conversation_id
    @faye            = options.faye
    @channel         = "/conversations/#{@conversation_id}"
    @call_sent       = false

    @collection      = new ICRMClient.Chat.MessagesCollection

    if @sender.get('type') == 'Visitor'
      @listenTo @collection, 'add', @_make_call

    @form_view = new ICRMClient.Chat.FormView
      conversation_id: @conversation_id
      collection:      @collection
      sender:          @sender
      ajax:            options.ajax

    @messages_view = new ICRMClient.Chat.MessagesView
      conversation_id: options.conversation_id
      collection: @collection

    (@faye.subscribe @channel, @_messageHandler, @).callback =>
      # callback for retrieve unread msgs only when channel is up and ready
      @messages_view.get_unread()

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

  _make_call: (model) =>
    if !@call_sent and model.get('sender').type == 'Visitor'
      @call_sent = true
      @faye.client.publish @faye.org_path + @channel,
        method: 'call',
        conversation_id: @conversation_id

  _create_message: (m) =>
    # Collection is smart to detect the existed message
    if m.sender.id == @sender.get('id') && m.sender.type == @sender.get('type')
      console.log "Got retranslated message"
    else
      @parent_controller.show()
      message = new ICRMClient.Chat.Message m
      @collection.add message

  _modify_message: (m) =>
    if message = @collection.get(m.id)
      console.log message
      message.set m
    else
      console.log "message does not exist in collection, id: #{m.id}"

  _messageHandler: (msg) ->
    switch msg.method
      when 'create' then @_create_message msg.message
      when 'modify' then @_modify_message msg.message
      else console.log "Unknown message method: #{msg.method}"
