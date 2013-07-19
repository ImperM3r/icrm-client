class ICRMClient.Widget.WindowView extends @ICRMClient.Backbone.View
  template: JST['widget/window_view']

  initialize: (options) ->
    @visitor_id = options.visitor_id

    @navigation = new ICRMClient.Widget.NavigationView $parent: @$el
    @chat_controller = new ICRMClient.Chat.ContainerView visitor_id: @visitor_id

  events:
    'click .convead_window_close' : '_hide'

  render: ->
    @$el.html( @template() ).hide() # starting hidden
    @

  toggleVisibility: =>
    @$el.toggle()

  _hide: =>
    @$el.hide()
