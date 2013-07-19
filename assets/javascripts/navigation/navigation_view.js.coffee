class ICRMClient.Widget.NavigationView extends @ICRMClient.Backbone.View
  template: JST['navigation/navigation_view']

  initialize: (options) ->
    @tab_views = []
    @buttons = []
    _.each options.tabs, (tab) =>
      @tab_views.push    tab.obj
      @buttons.push new ICRMClient.Widget.NavigationButton tab_id: tab.obj.id, tab_name: tab.name

  render: ->
    @$el.html @template()

    $buttons_el = @$el.find '#convead_client_navigation_tabset'
    for button in @buttons
      $buttons_el.append button.render().$el

    $tabs_el = @$el.find '#convead_client_navigation_tabs_content'
    for tab in @tab_views
      $tabs_el.append tab.render().$el

    @
