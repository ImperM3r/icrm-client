class ICRMClient.Chat.Chatter extends @ICRMClient.Backbone.Model
  initialize: (options) ->
    @set
      id:   options.id
      type: options.type


    if options.visitor_id
      @set name: 'Visitor Name'  # TODO Get visitor name from informer
    else
      console.error "Unkown chatter"
