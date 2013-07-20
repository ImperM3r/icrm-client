class ICRMClient.Chat.StandaloneController extends @ICRMClient.Backbone.View
  className: 'convead_client-widget-root'

  template: JST['widget/window_view']

  initialize: (options) ->
    @chat = new ICRMClient.Chat.ChatTabView
      sender: options.sender
      conversation_id: options.conversation_id
      parent_controller: @

  render: ->
    @$el.html( @template(@) )
    @$el.find('#convead_client_window_content').append @chat.render().$el

    ICRMClient.$('#icrm_chat').append @$el
    @

  show: ->
    # the stub for incoming messages

  events:
    'click .convead_window_close' : 'close'

window.ICRMClient.Chat.Start =(conversation_id) ->
  if window.ICRM
    sender = window.ICRM.manager
  else
    # Fake Manager for testing
    sender = 
      id: 1
      type: 'User'
      name: 'Danil Pismenny'

  @chat_controller = new window.ICRMClient.Chat.StandaloneController
    conversation_id: ICRMClient.visitor.id
    sender: sender

  @chat_controller.render()

  false
