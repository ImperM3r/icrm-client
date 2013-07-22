class ICRMClient.Chat.FormView extends @ICRMClient.Backbone.View
  template: JST['chat/form_view']

  conversation_url: window.ICRMClient.Assets.api_url + 'chat/conversation/'

  initialize: (options) ->
    @conversation_id  = options.conversation_id
    @sender           = options.sender
    @ajax_post        = options.ajax || window.ICRMClient.Base::ajax
    @post_url         = @conversation_url + @conversation_id

  events:
    'submit' : '_submitMessage'

  $textarea: ->
    @$el.find('textarea[name=content]')

  render: ->
    @$el.html @template()
    @

  _submitMessage: =>
    @_postMessage @$textarea().val()
    @$textarea().val ''
    false

  _postMessage: (content) =>
    message = new ICRMClient.Chat.Message
      sender:     @sender
      created_at: 'sending..'
      content:    content

    @collection.add message

    @ajax_post
      url: @post_url
      data: message.attributes
      success: (response) =>
        message.set response
