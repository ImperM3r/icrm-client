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
    @$el.addClass 'inactive' if @tab_view.disabled
    @

  inactivate: ->
    @active = false
    @tab_view.$el.hide()
    @render()

  activate: ->
    @active = true
    @tab_view.$el.show()
    @render()

  click: ->
    @nav_controller.selectTabView @ unless @tab_view.disabled
    false

  _unread_count: =>
    if @collection != undefined
      @collection.length - @collection.where( read: true ).length
    else
      0
