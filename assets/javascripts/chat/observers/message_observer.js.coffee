class ICRMClient.Chat.MessageObserver extends @ICRMClient.Base

  constructor: (options) ->
    _.extend @, window.ICRMClient.Backbone.Events

    @eb         = options.eb
    @collection = options.collection
    @sender     = options.sender

    @conversation_url = "#{@assets.api_url}chat/conversation/#{options.conversation.id}"
    @listenTo @collection, 'add', @_msgHandler

  _msgHandler: (model) =>
    # assume msg is new if no id present
    if      @_msgIsNew    model then @_postMessage model
    else if @_msgIsUnread model then @_markRead    model

  _msgIsNew: (model) =>
    !model.get('id')

  _msgIsUnread: (model) =>
    model.get('id') and model.get('read') != true and model.get('sender').id != @sender.get('id')

  _markRead: (model) =>
    @eb.trigger 'message:show'
    @ajax
      url: "#{@conversation_url}/message/#{model.get('id')}/mark_read"
      data: model.attributes
      success: (response) ->
        console.log "message id:#{model.get('id')} | read status: #{JSON.parse(response).status}"

  _postMessage: (model) =>
    model.set('sender', @sender.attributes)
    @ajax
      url: @conversation_url
      data: model.attributes
      success: (response) =>
        model.set response
