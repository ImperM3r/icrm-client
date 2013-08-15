class ICRMClient.Chat.StandaloneController extends @ICRMClient.Backbone.View
  template: JST['chat/standalone']
  className: 'convead_client-standalone_chat'

  initialize: (options) ->
    @eb             = options.event_broadcaster
    sender          = options.sender
    messages        = new ICRMClient.Chat.MessagesCollection()
    chat_controller = new ICRMClient.Widget.ChatController
      collection:      messages
      conversation_id: options.conversation_id
      sender:          sender
      faye:            options.faye

    new ICRMClient.Chat.MessageObserver
      collection: messages
      sender: sender
      conversation_id: options.conversation_id

    @chat = new ICRMClient.Chat.ChatTabView collection: messages

  render: ->
    @$el.html( @template(@) )
    content_el = @$ '.j-convead-client-widget-window-content'
    content_el.append @chat.render().$el
    if @$el.draggable?
      @$('.chat-standalone').draggable(containment: 'window').css position: "fixed", top: "10px", left: "10px"
    @

  # The stub for incoming messages
  show: ->
    @$el.show()
    @eb.trigger 'standalone:shown'

  close: ->
    @hide()

  hide: ->
    @$el.hide()
    @eb.trigger 'standalone:hidden'

  isVisible: ->
    @$el.is(":visible")

  toggleVisibility: ->
    @$el.toggle()

  events:
    'click .window_close' : 'close'


# Debugging helpers
window.ICRMClient.Chat.Start = (conversation_id) ->

  if window.ICRMClient.standalone_chat
    window.ICRMClient.standalone_chat.toggleVisibility()
  else
    # Fake Manager for testing
    sender = new window.ICRMClient.Chat.Chatter
      id: 1
      type: 'User'
      name: 'Danil Pismenny'

    window.ICRMClient.standalone_chat = new window.ICRMClient.Chat.StandaloneController
      event_broadcaster: window.ICRMClient.EventBroadcaster
      conversation_id:   ICRMClient.visitor.id
      sender:            sender
      faye:              window.ICRMClient.faye

    ICRMClient.$('#convead_client_container').append window.ICRMClient.standalone_chat.render().$el

  false
