class ICRMClient.Chat.MessagesView extends @ICRMClient.Backbone.View
  model_view: ICRMClient.Chat.MessageView
  el: 'ul.icrm_chat_messages_list'

  initialize: (options) ->
    @render()

    @listenTo @collection, 'add', (model) =>
      @append model

  append: (model) =>
    @$el.append new @model_view(model: model).render().el

  render: ->
    @$el.empty()

    @collection.each (model) =>
      @append model
