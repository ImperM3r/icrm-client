class ICRMClient.Widget.NavigationView extends @ICRMClient.Backbone.View
  template: JST['navigation/navigation_view']

  initialize: (options) ->
    @tab_views = options.tab_views
    @widget_view = options.parent
    @buttons = []

    for own key, tab_view of @tab_views
      @buttons.push new ICRMClient.Widget.NavigationButton nav_controller: @, tab_view: tab_view

  selectTabView: (button)->
    current_header_class = ''
    if @current_button
      @current_button.inactivate()
      current_header_class = @current_button.tab_view.header_class

    @widget_view.switchHeaderClass current_header_class, button.tab_view.header_class
    @current_button = button.activate()

  render: ->
    @$el.html @template(@)

    $buttons_el = @$el.find '#convead_client_navigation_tabset'
    for button in @buttons
      $buttons_el.append button.render().$el

    $tabs_el = @$el.find '#convead_client_navigation_tabs_content'
    for own key, tab of @tab_views
      $tabs_el.append tab.render().$el.hide()

    @selectTabView @buttons[0]
    @

  showNotification: (model) =>
    @tab_views.notification_tab.button.click()
    @tab_views.notification_tab.showNotification model
