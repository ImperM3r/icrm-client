class ICRMClient.Chat.MessageView extends @ICRMClient.Backbone.View
  tagName: 'li'
  attributes: ->
    id: @_id()
    class: @_class()

  initialize: (options) ->
    @listenTo @model, 'change', (model) => @render()

  template: JST['chat/message_view']

  render: =>
    @$el.attr 'id', @_id()
    @$el.attr 'class', @_class()
    @$el.html @template @model.presentation()
    @

  _id: =>
    'convead-message-' + @model.get('id')

  _class: =>
    type = if @model.get('sender') then @model.get('sender').type else 'Visitor'
    state = if @model.get('read') == true then 'read' else 'unread'
    "convead-message convead-sender-#{type} convead-message-#{state}"
