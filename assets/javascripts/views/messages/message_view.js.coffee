class ICRMClient.Views.MessageView extends @ICRMClient.Backbone.View
  tagName: 'li'
  className: ->
    if @model.attributes.sender == '__client__'
      return 'icrm-client-message'
    else
      return 'icrm-server-message'

  template: JST['messages/view']

  render: ->
    @$el.html @template @model.toJSON()
    @
