class ICRMClient.Views.MessageView extends @ICRMClient.Backbone.View
  tagName: 'li'
  id: ->
    'convead-message-' + @model.get('id')
  className: ->
    'convead-sender-' + @model.get('from_type')

  template: JST['messages/view']

  render: ->
    @$el.html @template @model.presentation()
    @
