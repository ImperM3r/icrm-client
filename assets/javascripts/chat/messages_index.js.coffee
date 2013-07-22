class ICRMClient.Chat.MessagesView extends @ICRMClient.Backbone.View
  model_view: ICRMClient.Chat.MessageView

  tagName: 'ul'
  className: 'icrm_chat_messages_list'

  initialize: (options) ->
    @message_api_url = window.ICRMClient.Assets.api_url + 'chat/conversation/' + options.conversation_id + '/message/'
    @render()

    @listenTo @collection, 'add', (model) =>
      @_mark_read model
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

  _mark_read: (model) =>
    return unless model.get('id')
    window.ICRMClient.Base::ajax
      url: @message_api_url + model.get('id') + '/mark_read'
      data: model.attributes
      success: (response) ->
        console.log "message id:#{model.get('id')} | read status: #{JSON.parse(response).status}"

