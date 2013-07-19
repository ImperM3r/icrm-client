class ICRMClient.Widget.NavigationView extends @ICRMClient.Backbone.View
  template: JST['navigation/navigation_view']

  initialize: (options) ->
    @tabs = []
    @buttons = []
    _.each options.tabs, (tab) =>
      @tabs.push    tab.obj
      @buttons.push new ICRMClient.Widget.NavigationButton tab_id: tab.obj.id, tab_name: tab.name

  render: ->
    @$el.html @template(@)
    @
