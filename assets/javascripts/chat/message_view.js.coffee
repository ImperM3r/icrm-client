class ICRMClient.Chat.MessageView extends @ICRMClient.Backbone.View
  tagName: 'li'
  id: ->
    'convead-message-' + @model.get('id')
  className: ->
    'convead-sender-' + @model.get('from_type')

  initialize: (options) ->
    @listenTo @model, 'change', (model) =>
      @render()

  template: JST['chat/message_view']

  render: ->
    @$el.html @template @model.presentation()
    @