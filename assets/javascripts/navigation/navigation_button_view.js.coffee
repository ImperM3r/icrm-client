class ICRMClient.Widget.NavigationButton extends @ICRMClient.Backbone.View
  template: JST['navigation/navigation_button']
  tagName: 'li'

  initialize: (options) ->
    @tab_view = options.tab_view
    @collection = @tab_view.collection
    @tab_view.button = @
    @nav_controller = options.nav_controller

    if @collection
      @listenTo @collection, 'add', @render
      @listenTo @collection, 'remove', @render
      @listenTo @collection, 'change', @render

  events:
    'click .tab' : 'click'

  render: ->
    @$el.html @template(@)
    if @tab_view.disabled()
      @$el.addClass 'inactive'
    else
      @$el.removeClass 'inactive'
    @

  inactivate: ->
    @active = false
    @tab_view.hide()
    @render()

  activate: ->
    @active = true
    @tab_view.show()
    @render()

  click: ->
    @nav_controller.selectTabView @ unless @tab_view.disabled()
    false

  _unreadCount: =>
    if @collection and func = @collection.unreadCount
      func.call()
