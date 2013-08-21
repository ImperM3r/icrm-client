class ICRMClient.Chat.MessageObserver extends @ICRMClient.Base

  constructor: (options) ->
    @_.extend @, window.ICRMClient.Backbone.Events

    @eb         = options.eb
    @collection = options.collection
    @sender     = options.sender

    @url = "#{@assets.chat_api_url}#{@sender.get('to_ident')}/conversations/#{options.conversation.id}/messages"
    @listenTo @collection, 'add', @_msgHandler

  close: => @stopListening()

  _msgHandler: (model) =>
    # assume msg is new if no id present
    if @_msgIsUnread model then @_markRead model
    if @_msgIsNew model then @_postMessage model

  _msgIsNew: (model) =>
    !model.get('id')

  _postMessage: (model) =>
    @ajax url: @url, data: model.attributes, success: (msg) -> model.set msg

  _msgIsUnread: (model) =>
    model.get('id') and model.get('read') != true and model.get('sender').id != @sender.get('id')

  _markRead: (model) =>
    if @_msgIsUnread(model)
      @eb.trigger 'message:show'
      @ajax
        url: "#{@url}/#{model.get('id')}/mark_read"
        data: model.attributes
        success: (response) -> console.log "message id:#{model.get('id')} | read status: #{response.status}"
