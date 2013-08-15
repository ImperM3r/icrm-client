class ICRMClient.Chat.MessagesView extends @ICRMClient.Backbone.View
  model_view: ICRMClient.Chat.MessageView

  tagName: 'ul'
  className: 'icrm_chat_messages_list'
  template: JST['chat/message_index']

  initialize: (options) ->
    @eb = options.eb
    @$last = null

    @listenTo @collection, 'add', (model) =>
      @append model

    @listenTo @eb, 'window:tab:chat:shown standalone:shown', =>
      @_scrollToLast() and @$last = null

  events:
    'click li.get-prev-messages': '_getPrevMsgs'

  append: (model) =>
    model.view = new @model_view model: model
    $msg_el = model.view.render().$el
    $msg_el.fadeIn 200

    if prev = @collection.prev model
      prev.view.$el.after $msg_el
    else
      @$('li.get-prev-messages').after $msg_el

    @$last = $msg_el
    @_scrollToLast()

  render: ->
    @$el.html @template(@)
    @$el.preventParentScroll()

    @collection.each (model) =>
      @append model
    @

  _getPrevMsgs: ->
    @eb.trigger 'messages:history:get'

  _scrollToLast: =>
    if @$last
      scrollY = @$last.position().top - @$('li.get-prev-messages').position().top
      if scrollY <= @$('li.get-prev-messages').outerHeight() then scrollY = 0
      @$el.scrollTop scrollY
