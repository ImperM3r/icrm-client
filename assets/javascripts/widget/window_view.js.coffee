class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  initialize: (options) ->
    @navigation = new ICRMClient.Widget.NavigationView
      tab_views:
        chat_tab: new ICRMClient.Chat.ChatTabView(
          sender:            new window.ICRMClient.Chat.Chatter(options.visitor),
          conversation_id:   options.visitor.id,
          faye:              window.ICRMClient.faye
          parent_controller: @,
        )
        notification_tab: new ICRMClient.Notifications.NotificationTabView(
          collection:        options.notifications,
          parent_controller: @
        )
        suggestion_tab: new ICRMClient.Suggestion.SuggestionTabView()
        problem_tab: new ICRMClient.Problem.ProblemTabView()
      parent: @

    actual_time $el: @$el

  events:
    'click a.window_close' : 'close'

  render: ->
    @$el.html( @template(@) ).hide() # starting hidden
    @$el.find('.j-convead-client-widget-window-content').append @navigation.render().$el
    @

  toggleVisibility: =>
    @$el.toggle()

  isVisibly: ->
    @$el.is(":visible")

  show: =>
    @$el.show()

  close: =>
    @hide()

  hide: =>
    @$el.hide()

  switchHeaderClass: (from, to) =>
    @$('.convead-client-lightbox').removeClass(from).addClass(to)

  showNotification: (model) =>
    @show()
    @navigation.showNotification model
