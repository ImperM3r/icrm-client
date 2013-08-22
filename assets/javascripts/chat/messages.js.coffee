class ICRMClient.Chat.MessagesCollection extends @ICRMClient.Backbone.Collection

  model: ICRMClient.Chat.Message

  @_srv_id: 0

  addServiceMsg: (text) ->
    @add new @model id: "srv##{@_srv_id++}", read: true, content: text, created_at: new Date
    console.log "service message: #{text}"

  comparator: (model) ->
    new Date(model.get('created_at')).getTime()
    #model.get('id')

  next: (model) =>
    index = @indexOf model
    return null if ++index > @length
    @at index

  prev: (model) =>
    index = @indexOf model
    return null if --index < 0
    @at index
