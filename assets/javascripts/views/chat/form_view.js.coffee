class ICRMClient.Chat.FormView extends @ICRMClient.Backbone.View
  el: '#icrm_chat form.respond_form'

  initialize: (options) ->
    @$content = @$('textarea[name="content"]')
    @parent = options.parent

  events:
    'submit' : '_submitMessage'

  _submitMessage: =>
    @parent.postMessage @$content.val()
    @$content.val('')
    false

