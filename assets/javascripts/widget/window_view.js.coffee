class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  initialize: (options) ->

    @navigation = new ICRMClient.Widget.NavigationView
      tabs: [
        { name: 'Conversation',  obj: new ICRMClient.Chat.ChatTabView visitor_id: options.visitor_id }
        { name: 'Notifications', obj: new ICRMClient.Notifications.NotificationTabView() }
        { name: 'Suggestion',    obj: new ICRMClient.Suggestion.SuggestionTabView() }
        { name: 'Problem',       obj: new ICRMClient.Problem.ProblemTabView() }
      ]

  events:
    'click .convead_window_close' : '_hide'

  render: ->
    @$el.html( @template(@) ).hide() # starting hidden
    @

  toggleVisibility: =>
    @$el.toggle()

  _hide: =>
    @$el.hide()
