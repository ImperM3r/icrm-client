class ICRMClient.Chat.MessagesView extends @ICRMClient.Backbone.View
  model_view: ICRMClient.Chat.MessageView

  tagName: 'ul'
  className: 'icrm_chat_messages_list'

  initialize: (options) ->
    @render()

    @listenTo @collection, 'add', (model) =>
      @append model

  append: (model) =>
    $msg_el = new @model_view(model: model).render().$el
    $msg_el.fadeIn 200

    @$el.append $msg_el

  render: ->
    @$el.empty()

    @collection.each (model) =>
      @append model
    @
