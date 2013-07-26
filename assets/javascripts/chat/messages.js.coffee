class ICRMClient.Chat.MessagesCollection extends @ICRMClient.Backbone.Collection

  model: ICRMClient.Chat.MessageModel

  comparator: (model) ->
    model.get('createad_at')

  next: (model) =>
    index = @indexOf model
    return null if ++index > @length
    @at index

  prev: (model) =>
    index = @indexOf model
    return null if --index < 0
    @at index
