class ICRMClient.Chat.MessageObserver extends @ICRMClient.Base

  constructor: (options) ->
    @_.extend @, window.ICRMClient.Backbone.Events

    @eb         = options.eb
    @collection = options.collection
    @author     = options.author

    @url = "#{@assets.chat_api_url}#{@author.get('to_ident')}/conversations/#{options.conversation.id}/messages"
    @listenTo @collection, 'add change', @_msgHandler

  close: => @stopListening()

  _msgHandler: (model) =>
    # assume msg is new if no id present
    if @_msgIsUnread model then @_markRead model
    if @_msgIsNew model then @_postMessage model

  _msgIsNew: (model) =>
    !model.get('id')

  _postMessage: (model) =>
    return unless model.get('content')
    @ajax url: @url, data: model.attributes, success: (msg) -> 
      model.set msg.message
      console.log "renew msg: #{JSON.stringify msg}"

  _msgIsUnread: (model) =>
    model.get('id') and model.get('read') != true

  _markRead: (model) =>
    @eb.trigger 'message:show'
    @ajax
      url: "#{@url}/#{model.get('id')}/mark_read"
      data: model.attributes
      success: (msg) -> console.log "message id:#{model.get('id')} | read status: #{msg.state}"
