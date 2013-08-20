class ICRMClient.Chat.ChatController extends @ICRMClient.Base
  constructor: (options) ->
    @_.extend @, ICRMClient.Backbone.Events

    @eb                = options.eb
    @collection        = options.collection
    @sender            = options.sender
    @faye              = options.faye

    if @sender.get('type') == 'Visitor'
      visitor_id = @sender.get('id')
    else
      visitor_id = options.visitor_id

    @service_channel  = "/service/visitor/#{visitor_id}"
    @service_url      = "#{@assets.api_url}chat/service/#{visitor_id}"

    service_channel = @faye.subscribe @service_channel, @_serviceHandler
    service_channel.callback =>
      @ajax
        url: @service_url + '/online'
        data: { sender: @sender.attributes }
        success: => console.log 'check for open conversations'

    @listenTo @eb, 'window:shown standalone:shown', =>
      return if @conversation_controller
      @ajax
        url: @service_url + '/calling'
        data: { sender: @sender.attributes }
        success: => console.log "establish conversation attempt successfull"
        error: (response) =>
          msg = response.responseText
          @collection.add new @collection.model
            content: msg
            created_at: new Date
            id: 0
            read: true
          console.log "establish conversation attempt failed"

  _serviceHandler: (msg) =>
    switch msg.event
      when 'calling' then @_newConversation msg.conversation
      when 'close_conversation' then @_closeConversation(); @eb.trigger 'window:close'
      else console.log msg

  _newConversation: (conversation) =>
    return if @conversation_controller
    options = eb: @eb, conversation: conversation, collection: @collection, sender: @sender, faye: @faye
    @conversation_controller = new ICRMClient.Chat.ConversationController options,
      success: =>
        @eb.trigger 'message:show'
        console.log "new conversation initialized #{JSON.stringify(conversation)}"
      error: => @conversation_controller = false
