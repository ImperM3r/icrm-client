class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  initialize: (options) ->
    @visitor_id = options.visitor_id

  events:
    'click .convead_window_close' : '_hide'

  append_to: ($parent_el) =>
    $parent_el.append @render().el
    @_initSubViews()

  render: ->
    @$el.html(@template()).hide() # starting hidden
    @

  toggleVisibility: =>
    @$el.toggle()

  _hide: =>
    @$el.hide()

  _initSubViews: ->
    new ICRMClient.Widget.NavigationView $parent: @$el
    new ICRMClient.Chat.ContainerView visitor_id: @visitor_id
