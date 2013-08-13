class ICRMClient.Chat.MessagesView extends @ICRMClient.Backbone.View
  model_view: ICRMClient.Chat.MessageView

  tagName: 'ul'
  className: 'icrm_chat_messages_list'

  initialize: (options) ->
    @conversation_url = window.ICRMClient.Assets.api_url + 'chat/conversation/' + options.conversation_id
    @message_api_url =  @conversation_url + '/message/'

    @listenTo @collection, 'add', (model) =>
      @_mark_read model
      @append model

  append: (model) =>
    model.view = new @model_view model: model
    $msg_el = model.view.render().$el
    $msg_el.fadeIn 200

    if prev = @collection.prev model
      prev.view.$el.after $msg_el
    else
      @$el.prepend $msg_el

    @$el.scrollTop @$el.prop('scrollHeight')

  render: ->
    @$el.empty()
    @$el.preventParentScroll()

    @collection.each (model) =>
      @append model
    @

  get_last: ->
    window.ICRMClient.Base::ajax
      url: @conversation_url + '/get_last'
      success: (response) =>
        console.log "recieved last #{response.length} messages"
        @collection.add( new @collection.model message ) for message in response

  _mark_read: (model) =>
    return unless model.get('id') and model.get('read') != true
    window.ICRMClient.Base::ajax
      url: @message_api_url + model.get('id') + '/mark_read'
      data: model.attributes
      success: (response) ->
        console.log "message id:#{model.get('id')} | read status: #{JSON.parse(response).status}"
