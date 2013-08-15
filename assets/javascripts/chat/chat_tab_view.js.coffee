class ICRMClient.Chat.ChatTabView extends @ICRMClient.Backbone.View
  tagName: 'div'
  className: 'convead_chat_holder'
  header_class: 'conversation'
  tab_name: @.prototype.t 'widget.tab.conversation'

  disabled: -> false

  initialize: (options) ->
    @eb = window.ICRMClient.EventBroadcaster

    @form_view     = new ICRMClient.Chat.FormView     collection: @collection
    @messages_view = new ICRMClient.Chat.MessagesView collection: @collection

    @listenTo @eb, 'window:shown', (e) =>
      if @button and @button.active
        @eb.trigger 'window:tab:chat:shown'

  render: ->
    @$el.append @messages_view.render().$el
    @$el.append @form_view.render().$el
    @

  show: ->
    @$el.show()
    @eb.trigger 'window:tab:chat:shown'

  hide: ->
    @$el.hide()
    @eb.trigger 'window:tab:chat:hidden'
