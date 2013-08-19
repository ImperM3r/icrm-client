class ICRMClient.Chat.MessageObserver extends @ICRMClient.Base

  constructor: (options) ->
    _.extend @, window.ICRMClient.Backbone.Events

    @eb         = options.eb
    @collection = options.collection
    @sender     = options.sender

    @conversation_url = "#{@assets.api_url}chat/conversation/#{options.conversation.id}"
    @listenTo @collection, 'add', @_msgHandler

  close: => @stopListening()

  _msgHandler: (model) =>
    # assume msg is new if no id present
    if @_msgIsNew model then @_postMessage model

  _msgIsNew: (model) =>
    !model.get('id')

  _postMessage: (model) =>
    model.set('sender', @sender.attributes)
    @ajax
      url: @conversation_url
      data: model.attributes
      success: (response) =>
        model.set response
