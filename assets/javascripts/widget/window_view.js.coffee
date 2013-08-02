class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  initialize: (options) ->
    @navigation = new ICRMClient.Widget.NavigationView
      tab_views: [
        new ICRMClient.Chat.ChatTabView(
          sender:            new window.ICRMClient.Chat.Chatter(options.visitor),
          conversation_id:   options.visitor.id,
          faye:              window.ICRMClient.faye
          parent_controller: @,
        ),
        new ICRMClient.Notifications.NotificationTabView(
          collection:        options.collections.notifications,
          visitor:           options.visitor,
          faye:              window.ICRMClient.faye,
          parent_controller: @
        ),
        new ICRMClient.Suggestion.SuggestionTabView(),
        new ICRMClient.Problem.ProblemTabView()
      ]
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
