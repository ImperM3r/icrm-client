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

    @faye.subscribe @service_channel, @_serviceHandler

    @listenTo @eb, 'window:shown standalone:shown', =>
      return if @conversation_open
      @ajax
        url: "#{@assets.api_url}chat/service/#{visitor_id}"
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

  _serviceHandler: (msg) =>
    switch msg.entity
      when 'conversation' then @_newConversation msg.conversation
      else console.log msg

  _newConversation: (conversation) =>
    return if @conversation_open
    @conversation_open = true
    options = eb: @eb, conversation: conversation, collection: @collection, sender: @sender, faye: @faye
    new ICRMClient.Chat.ConversationController options,
      success: => new ICRMClient.Chat.MessageObserver options
      error: => @conversation_open = false
