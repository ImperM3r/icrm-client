class ICRMClient.Chat.ChatTabView extends @ICRMClient.Backbone.View
  tagName: 'div'
  className: 'convead_chat_holder'
  header_class: 'conversation'
  tab_name: @.prototype.t 'widget.tab.conversation'

  disabled: -> false

  initialize: (options) ->
    @eb = options.eb

    @form_view     = new ICRMClient.Chat.FormView     collection: @collection, eb: @eb
    @messages_view = new ICRMClient.Chat.MessagesView collection: @collection, eb: @eb

    @listenTo @eb, 'window:shown', (e) =>
      if @button and @button.active
        @eb.trigger 'window:tab:chat:shown'

    @listenTo @eb, 'window:tab:chat:show', =>
      @show()

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
