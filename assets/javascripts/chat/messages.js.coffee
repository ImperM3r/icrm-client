class ICRMClient.Chat.MessagesCollection extends @ICRMClient.Backbone.Collection

  model: ICRMClient.Chat.MessageModel

  comparator: (model) ->
    #new Date(model.get('created_at')).getTime()
    model.get('id')

  next: (model) =>
    index = @indexOf model
    return null if ++index > @length
    @at index

  prev: (model) =>
    index = @indexOf model
    return null if --index < 0
    @at index
