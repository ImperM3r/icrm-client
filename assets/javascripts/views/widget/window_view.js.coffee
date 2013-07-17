class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  render: ->
    @$el.html(@template()).hide() # starting hidden
    @

  toggleVisibility: =>
    @$el.toggle()
