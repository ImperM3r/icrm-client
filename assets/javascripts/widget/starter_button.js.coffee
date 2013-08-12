class ICRMClient.Widget.StarterButtonView extends @ICRMClient.Backbone.View
  template: JST['widget/starter_button_view']

  initialize: (options) ->
    @window = options.window

  events:
    'click': '_toggleWindowVisibility'

  render: ->
    if window.ICRM_Settings.widget || ICRMClient.Utils.gup('convead_widget')
      @$el.html @template(@)
    @

  _toggleWindowVisibility: (e) =>
    @window.toggleVisibility()
