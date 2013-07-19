class ICRMClient.Widget.NavigationButton extends @ICRMClient.Backbone.View
  template: JST['navigation/navigation_button']
  tagName: 'li'

  initialize: (options) ->
    @tab_id   = options.tab_id
    @tab_name = options.tab_name

  render: ->
    @$el.html @template(@)
    @
