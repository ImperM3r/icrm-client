class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  events:
    'click .icrm_window_close' : '_hide'

  render: ->
    @$el.html(@template()).hide() # starting hidden
    @

  toggleVisibility: =>
    @$el.toggle()

  _hide: =>
    @$el.hide()
