class ICRMClient.Widget.NavigationButton extends @ICRMClient.Backbone.View
  template: JST['navigation/navigation_button']
  tagName: 'li'

  initialize: (options) ->
    @tab_view = options.tab_view
    @nav_controller = options.nav_controller

  events:
    'click .tab' : '_click'

  render: ->
    @$el.html @template(@)
    @

  _click: ->
    @nav_controller.selectTabView @tab_view

    false
