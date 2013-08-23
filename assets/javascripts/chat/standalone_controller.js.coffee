class ICRMClient.Chat.StandaloneController extends @ICRMClient.Backbone.View
  template: JST['chat/standalone']
  className: 'convead_client-standalone_chat'

  initialize: (options) ->
    @eb = @_.extend {}, ICRMClient.Backbone.Events
    author          = options.author
    messages        = new ICRMClient.Chat.MessagesCollection()
    chat_controller = new ICRMClient.Chat.ChatController
      recipient_ident: options.recipient_ident
      eb:              @eb
      collection:      messages
      author:          author
      faye:            options.faye

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

  minimize: ->
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

  close: ->
    @eb.trigger 'standalone:close'
    @stopListening()
    @$el.remove()

  events:
    'click .window_close' : 'close'
    'click .window_minimize' : 'minimize'


# Debugging helpers
window.ICRMClient.Chat.Start = (conversation_id) ->

  if window.ICRMClient.standalone_chat
    window.ICRMClient.standalone_chat.toggleVisibility()
  else
    # Fake Manager for testing
    author = new window.ICRMClient.Chat.Chatter
      id: 10
      type: 'User'
      name: 'Danil Pismenny'
      to_ident: 'Manager-10'

    chat = window.ICRMClient.standalone_chat = new window.ICRMClient.Chat.StandaloneController
      recipient_ident: ICRMClient.visitor.to_ident
      author:          author
      faye:            window.ICRMClient.faye

    ICRMClient.$('#convead_client_container').append chat.render().$el
    chat.show()

  false
