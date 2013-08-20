class ICRMClient.Chat.StandaloneController extends @ICRMClient.Backbone.View
  template: JST['chat/standalone']
  className: 'convead_client-standalone_chat'

  initialize: (options) ->
    @eb = _.extend {}, ICRMClient.Backbone.Events
    sender          = options.sender
    messages        = new ICRMClient.Chat.MessagesCollection()
    chat_controller = new ICRMClient.Chat.ChatController
      visitor_id: options.visitor_id
      eb:         @eb
      collection: messages
      sender:     sender
      faye:       options.faye

    @chat = new ICRMClient.Chat.ChatTabView collection: messages, eb: @eb

    @listenTo @eb, 'message:show', => @show()

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
    @button.trigger 'show' if @button

  close: ->
    @hide()

  hide: ->
    @$el.hide()
    @eb.trigger 'standalone:hidden'
    @button.trigger 'hide' if @button

  isVisible: ->
    @$el.is(":visible")

  toggleVisibility: ->
    if @isVisible()
      @hide()
    else
      @show()

  events:
    'click .window_close' : 'close'


# Debugging helpers
window.ICRMClient.Chat.Start = (conversation_id) ->

  if window.ICRMClient.standalone_chat
    window.ICRMClient.standalone_chat.toggleVisibility()
  else
    # Fake Manager for testing
    sender = new window.ICRMClient.Chat.Chatter
      id: 10
      type: 'User'
      name: 'Danil Pismenny'

    chat = window.ICRMClient.standalone_chat = new window.ICRMClient.Chat.StandaloneController
      visitor_id: ICRMClient.visitor.id
      sender:     sender
      faye:       window.ICRMClient.faye

    ICRMClient.$('#convead_client_container').append chat.render().$el
    chat.show()

  false
