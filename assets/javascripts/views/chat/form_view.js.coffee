class ICRMClient.Chat.FormView extends @ICRMClient.Backbone.View
  el: '#icrm_chat form.respond_form'

  events:
    'submit' : '_submitMessage'

  _submitMessage: =>
    @collection.add new @collection.model @$el.serialize()
    false

