class ICRMClient.Notifications.NotificationListView extends @ICRMClient.Backbone.View
  tagName: 'ul'
  className: 'listing'

  initialize: (options) ->
    @tab_view = options.tab_view
    @tab_view.register_view @

    @listenTo @collection, 'add', @append

  append: (model) =>
    list_item_view = new ICRMClient.Notifications.NotificationListItemView model: model, tab_view: @tab_view
    @$el.append list_item_view.render().el

  activate: (view) =>
    if view == @
      @$el.show()
    else
      @$el.hide()
