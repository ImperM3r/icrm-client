class ICRMClient.Chat.ChatTabView extends @ICRMClient.Backbone.View
  tagName: 'div'
  className: 'convead_chat_holder'
  header_class: 'conversation'
  tab_name: @.prototype.t 'widget.tab.conversation'

  disabled: -> false

  initialize: (options) ->
    @eb = window.ICRMClient.EventBroadcaster

    @form_view = new ICRMClient.Chat.FormView collection: @collection
    @messages_view = new ICRMClient.Chat.MessagesView collection: @collection

    @listenTo @eb, 'window:shown', (e) =>
      if @button.active
        @eb.trigger 'window:tab:chat:shown'

  render: ->
    @$el.append @messages_view.render().$el
    @$el.append @form_view.render().$el
    @
