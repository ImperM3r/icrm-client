class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  initialize: (options) ->

    @navigation = new ICRMClient.Widget.NavigationView
      tabs: [
        new ICRMClient.Chat.ChatTabView visitor_id: options.visitor_id
        new ICRMClient.Notifications.NotificationTabView()
        new ICRMClient.Suggestion.SuggestionTabView()
        new ICRMClient.Problem.ProblemTabView()
      ]

  events:
    'click .convead_window_close' : '_hide'

  render: ->
    @$el.html( @template() ).hide() # starting hidden
    @$('.convead_navigation').append @navigation.render().el
    @

  toggleVisibility: =>
    @$el.toggle()

  _hide: =>
    @$el.hide()
