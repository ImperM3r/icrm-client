class ICRMClient.Chat.FormView extends @ICRMClient.Backbone.View
  el: '#icrm_chat form.respond_form'
  messages_url: window.ICRMClient.Assets.api_url + 'chat/messages'

  initialize: (options) ->
    @$content = @$('textarea[name="content"]')

    @visitor_id = options.visitor_id
    @from_id    = options.visitor_id
    @from_type  = 'Visitor'

  events:
    'submit' : '_postMessage'

  _postMessage: =>
    message = new @collection.model
      visitor_id: @visitor_id
      from_type:  @from_type
      from_id:    @from_id
      created_at: 'sending..'
      content:    @$content.val()

    @collection.add message

    @$content.val ''

    window.ICRMClient.Base::ajax
      url: @messages_url
      data: message.attributes
      success: (response) =>
        message.set response

    false

