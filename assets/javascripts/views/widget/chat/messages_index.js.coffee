class ICRMClient.Widget.Chat.MessagesView extends @ICRMClient.Backbone.View
  model_view: ICRMClient.Widget.Chat.MessageView
  el: 'ul.icrm-chat-messages-list'

  initialize: (options) ->
    @render()

    @listenTo @collection, 'add', (model) =>
      @append model

  append: (model) =>
    @$el.append new @model_view(model: model).render().el

  render: ->
    @$el.empty()

    @collection.each (model) =>
      @add model
