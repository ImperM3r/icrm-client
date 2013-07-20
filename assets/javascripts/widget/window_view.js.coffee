class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  initialize: (options) ->

    @navigation = new ICRMClient.Widget.NavigationView
      tab_views: [
        new ICRMClient.Chat.ChatTabView( visitor: options.visitor, window_view: @),
        new ICRMClient.Notifications.NotificationTabView(),
        new ICRMClient.Suggestion.SuggestionTabView(),
        new ICRMClient.Problem.ProblemTabView()
      ]

  events:
    'click .convead_window_close' : 'hide'

  render: ->
    @$el.html( @template(@) ).hide() # starting hidden
    @$el.find('#convead_client_navigation').append @navigation.render().$el
    @

  toggleVisibility: =>
    @$el.toggle()

  isVisibly: ->
    @$el.is(":visible")

  show: =>
    @$el.show()

  hide: =>
    @$el.hide()
