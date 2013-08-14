class ICRMClient.Chat.FormView extends @ICRMClient.Backbone.View
  template: JST['chat/form_view']

  conversation_url: window.ICRMClient.Assets.api_url + 'chat/conversation/'

  initialize: (options) ->
    @eb = window.ICRMClient.EventBroadcaster
    @conversation_id  = options.conversation_id
    @sender           = options.sender
    @post_url         = @conversation_url + @conversation_id
    @ajax             = options.ajax || window.ICRMClient.Base::ajax

    @listenTo @eb, 'window:tab:chat:shown', (e) =>
      @$textarea().focus()

  events:
    'submit' : '_submitMessage'

  $textarea: ->
    @$el.find('textarea[name=content]')

  render: ->
    @$el.html @template(@)
    @$textarea().submitByEnter()
    @

  _submitMessage: =>
    @postMessage @$textarea().val()
    @$textarea().val ''
    false

  postMessage: (content) =>
    message = new ICRMClient.Chat.Message
      sender:     @sender.attributes
      created_at: 'sending..'
      content:    content

    @collection.add message

    @ajax
      url: @post_url
      data: message.attributes
      success: (response) =>
        message.set response
