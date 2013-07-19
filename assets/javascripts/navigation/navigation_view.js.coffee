class ICRMClient.Widget.NavigationView extends @ICRMClient.Backbone.View
  template: JST['navigation/navigation_view']

  initialize: (options) ->
    @tabs = options.tabs
    @buttons = []
    _.each @tabs, (tab) =>
      @buttons.push new ICRMClient.Widget.NavigationButton tab_id: tab.id, tab_name: tab.tab_name

  render: ->
    @$el.html @template(@)
    @
