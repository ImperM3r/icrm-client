class ICRMClient.Chat.FormView extends @ICRMClient.Backbone.View
  template: JST['chat/form_view']

  initialize: (options) ->
    @eb = options.eb
    @listenTo @eb, 'window:tab:chat:shown standalone:shown', (e) =>
      @$textarea().focus()

  events:
    'submit' : '_submitMessage'

  $textarea: ->
    @$('textarea[name=content]')

  render: ->
    @$el.html @template(@)
    @$textarea().submitByEnter()
    @

  _submitMessage: =>
    @_postMessage @$textarea().val()
    @$textarea().val ''
    false

  _postMessage: (content) =>
    @collection.add  new @collection.model(created_at: 'sending...', content: content)
