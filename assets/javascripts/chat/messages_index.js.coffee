class ICRMClient.Chat.MessagesView extends @ICRMClient.Backbone.View
  model_view: ICRMClient.Chat.MessageView

  tagName: 'ul'
  className: 'icrm_chat_messages_list'

  initialize: (options) ->
    @conversation_url = window.ICRMClient.Assets.api_url + 'chat/conversation/' + options.conversation_id
    @message_api_url =  @conversation_url + '/message/'
    @_get_unread()

    @listenTo @collection, 'add', (model) =>
      @_mark_read model
      @append model

  append: (model) =>
    $msg_el = new @model_view(model: model).render().$el
    $msg_el.fadeIn 200
    @$el.append $msg_el
    @$el.animate { scrollTop: @$el.prop('scrollHeight') }, "slow"

  render: ->
    @$el.empty()

    @collection.each (model) =>
      @append model
    @

  _mark_read: (model) =>
    return unless model.get('id') and model.get('read') != true
    window.ICRMClient.Base::ajax
      url: @message_api_url + model.get('id') + '/mark_read'
      data: model.attributes
      success: (response) ->
        console.log "message id:#{model.get('id')} | read status: #{JSON.parse(response).status}"

  _get_unread: ->
    window.ICRMClient.Base::ajax
      url: @conversation_url + '/get_unread'
      success: (response) ->
        console.log "to send: [#{JSON.parse(response).count}] unread messages"
