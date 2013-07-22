class ICRMClient.Chat.StandaloneController extends @ICRMClient.Backbone.View
  template: JST['chat/standalone']
  className: 'convead_client-standalone_chat'

  initialize: (options) ->
    @chat = new ICRMClient.Chat.ChatTabView
      sender: options.sender
      faye:   options.faye
      ajax:   options.ajax
      conversation_id: options.conversation_id
      parent_controller: @

    @chat.form_view.postMessage("initiated chat...") if options.sender.get('type') == 'User'

  render: ->
    @$el.html( @template(@) )
    content_el = @$el.find('.j-convead-client-widget-window-content')
    content_el.append @chat.render().$el

    @

  # The stub for incoming messages
  show: ->
    @$el.show()

  close: ->
    @hide()

  hide: ->
    @$el.hide()

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
      conversation_id: ICRMClient.visitor.id
      sender: sender
      faye: window.ICRMClient.faye

    ICRMClient.$('#convead_client_container').append window.ICRMClient.standalone_chat.render().$el

  false
