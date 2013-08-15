class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  initialize: (options) ->
    @eb = window.ICRMClient.EventBroadcaster
    @navigation = new ICRMClient.Widget.NavigationView
      parent: @
      tab_views:
        chat_tab:         new ICRMClient.Chat.ChatTabView collection: options.messages
        notification_tab: new ICRMClient.Notifications.NotificationTabView collection: options.notifications
        suggestion_tab:   new ICRMClient.Suggestion.SuggestionTabView()
        problem_tab:      new ICRMClient.Problem.ProblemTabView()

  events:
    'click a.window_close' : 'close'

  render: ->
    @$el.html( @template(@) ).hide() # starting hidden
    @$el.find('.j-convead-client-widget-window-content').append @navigation.render().$el
    @

  toggleVisibility: =>
    if @isVisibly()
      @hide()
    else
      @show()

  isVisibly: ->
    @$el.is(":visible")

  show: =>
    @$el.show()
    @eb.trigger 'window:shown'

  close: =>
    @hide()

  hide: =>
    @$el.hide()
    @eb.trigger 'window:hidden'

  switchHeaderClass: (from, to) =>
    @$('.convead-client-lightbox').removeClass(from).addClass(to)

  showNotification: (model) =>
    return false if @isVisibly()
    @show()
    @navigation.showNotification model

  showMessage: =>
    return false if @isVisibly()
    @show()
    @navigation.showMessage()
