class ICRMClient.Chat.ChatController extends @ICRMClient.Base

  constructor: (options) ->
    _.extend @, ICRMClient.Backbone.Events

    @conversation_open = false

    @eb                = options.eb
    @collection        = options.collection
    @sender            = options.sender
    @faye              = options.faye

    if @sender.get('type') == 'Visitor'
      visitor_id = @sender.get('id')
    else
      visitor_id = options.visitor_id

    @service_channel  = "/service/#{visitor_id}"
    @service_url      = "#{@assets.api_url}chat/service/#{visitor_id}"

    @_getHistory()

    service_channel = @faye.subscribe @service_channel, @_serviceHandler
    service_channel.callback =>
      @ajax
        url: @service_url + '/check'
        data: { sender: @sender.attributes }
        success: => console.log 'check for open conversations'

    @listenTo @collection, 'add', @_markRead

    @listenTo @eb, 'messages:history:get', (e) =>
      since_id = if first = @collection.first() then first.get('id') else undefined
      @_getHistory since_id

    @listenTo @eb, 'window:shown standalone:shown', =>
      return if @conversation_open
      @ajax
        url: @service_url
        data: { sender: @sender.attributes }
        success: => console.log "establish conversation attempt successfull"
        error: (response) =>
          msg = response.responseJSON.error
          @collection.add @collection.model
            content: msg
            created_at: new Date
            id: 0
            read: true
          console.log "establish conversation attempt failed"

    @listenTo @eb, 'window:hidden', @_initCloseConversation

  _serviceHandler: (msg) =>
    switch msg.event
      when 'open_conversation' then @_newConversation msg.conversation
      when 'close_conversation' then @_closeConversation(); @eb.trigger 'window:close'
      else console.log msg

  _newConversation: (conversation) =>
    return if @conversation_open
    @conversation_open = true
    options = eb: @eb, conversation: conversation, collection: @collection, sender: @sender, faye: @faye
    @conversation_controller = new ICRMClient.Chat.ConversationController options,
      success: =>
        @eb.trigger 'message:show'
        console.log "new conversation initialized #{JSON.stringify(conversation)}"
      error: => @conversation_open = false

  _initCloseConversation: =>
    return unless @conversation_open
    @conversation_open = false
    if @conversation_controller
      @conversation_controller.initClose
        error: =>
          @conversation_open = true
          console.log 'cannot close conversation'

  _closeConversation: =>
    @conversation_open = false
    @conversation_controller.close()
    delete @conversation_controller
    console.log 'conversation closed'

  _getHistory: (since_id) =>
    @ajax
      url: @service_url + '/messages'
      data: { since_id: since_id, count: window.ICRMClient.history_count }
      success: (response) =>
        console.log "recieved last #{response.length} messages"
        @collection.add( new @collection.model message ) for message in response by -1

  _msgIsUnread: (model) =>
    model.get('id') and model.get('read') != true and model.get('sender').id != @sender.get('id')

  _markRead: (model) =>
    if @_msgIsUnread(model)
      @eb.trigger 'message:show'
      @ajax
        url: "#{@service_url}/message/#{model.get('id')}/mark_read"
        data: model.attributes
        success: (response) ->
          if response.status != false then model.set response.message
          console.log "message id:#{model.get('id')} | read status: #{response.status}"
