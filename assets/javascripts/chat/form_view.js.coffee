class ICRMClient.Chat.FormView extends @ICRMClient.Backbone.View
  template: JST['chat/form_view']

  initialize: (options) ->
    @eb = options.eb

    @listenTo @eb, 'window:tab:chat:shown standalone:shown', => @$textarea().focus()
    @listenTo @eb, 'conversation:opened', @_enableForm
    @listenTo @eb, 'conversation:closed', @_disableForm

  events:
    'submit' : '_submitMessage'

  $textarea: ->
    @$('textarea[name=content]')

  render: ->
    @$el.html @template(@)
    @$textarea().submitByEnter()
    @eb.trigger 'conversation:status'
    @

  _submitMessage: =>
    @_postMessage @$textarea().val()
    @$textarea().val ''
    false

  _postMessage: (content) =>
    @collection.add  new @collection.model(created_at: 'sending...', content: content)

  _disableForm: =>
    @$textarea().attr 'disabled', 'disabled'
    @$('input[type="submit"]').attr 'disabled', 'disabled'

  _enableForm: =>
    @$('input[type="submit"]').removeAttr 'disabled'
    @$textarea().removeAttr('disabled').focus()
