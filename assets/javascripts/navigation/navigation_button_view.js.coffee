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

  inactivate: ->
    @$('a.tab').removeClass 'active'
    @tab_view.$el.hide()
    @

  activate: ->
    @$('a.tab').addClass 'active'
    @tab_view.$el.show()
    @

  _click: ->
    @nav_controller.selectTabView @ unless @tab_view.disabled
    false
