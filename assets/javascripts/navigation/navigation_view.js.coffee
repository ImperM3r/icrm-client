class ICRMClient.Widget.NavigationView extends @ICRMClient.Backbone.View
  template: JST['navigation/navigation_view']

  initialize: (options) ->
    @tab_views = options.tab_views
    @buttons = []

    for tab_view in @tab_views
      @buttons.push new ICRMClient.Widget.NavigationButton nav_controller: @, tab_view: tab_view

  selectTabView: (button)->
    if button != @current_button
      @current_button.inactivate() if @current_button
      @current_button = button.activate()

  render: ->
    @$el.html @template()

    $buttons_el = @$el.find '#convead_client_navigation_tabset'
    for button in @buttons
      $buttons_el.append button.render().$el

    $tabs_el = @$el.find '#convead_client_navigation_tabs_content'
    for tab in @tab_views
      $tabs_el.append tab.render().$el.hide()

    @selectTabView @buttons[0]
    @
