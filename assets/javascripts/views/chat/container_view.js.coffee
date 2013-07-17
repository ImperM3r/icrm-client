class ICRMClient.Chat.ContainerView extends @ICRMClient.Backbone.View
  el: '#icrm_chat .icrm_chat_holder'

  initialize: (options) ->
    new ICRMClient.Chat.MessagesView
      collection: @collection

    new ICRMClient.Chat.FormView
      collection: @collection
      visitor_id: options.visitor_id
