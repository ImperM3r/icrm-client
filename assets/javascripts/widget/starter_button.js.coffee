class ICRMClient.Widget.StarterButtonView extends @ICRMClient.Backbone.View
  template: JST['widget/starter_button_view']

  initialize: (options) ->
    @window = options.window

  events:
    'click': '_toggleWindowVisibility'

  render: ->
    @$el.html @template()
    @

  _toggleWindowVisibility: =>
    @window.toggleVisibility()
