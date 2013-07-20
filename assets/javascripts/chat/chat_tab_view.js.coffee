class ICRMClient.Chat.ChatTabView extends @ICRMClient.Backbone.View
  tagName: 'div'
  id: 'convead_chat_holder'

  initialize: (options) ->
    @collection = new ICRMClient.Chat.MessagesCollection()
    @visitor_id = options.visitor_id
    @from_id    = options.visitor_id
    @from_type  = 'Visitor'

    @form_view = new ICRMClient.Chat.FormView
      collection: @collection
      visitor_id: @visitor_id

    @messages_view = new ICRMClient.Chat.MessagesView
      collection: @collection

    window.ICRMClient.faye.subscribe "/chat/#{@visitor_id}", @_messageHandler, @

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

  render: ->
    @$el.append @messages_view.render().$el
    @$el.append @form_view.render().$el
    @

  _messageHandler: (msg) ->
    if msg.method == 'create'
      # Collection is smart to detect the existed message
      if msg.message.from_id == @from_id && msg.message.from_type == @from_type
        console.log "message from me"
      else
        @collection.add msg.message
