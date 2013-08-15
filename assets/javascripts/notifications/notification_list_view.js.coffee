class ICRMClient.Notifications.NotificationListView extends @ICRMClient.Backbone.View
  tagName: 'ul'
  className: 'convead-listing'

  initialize: (options) ->
    @tab_view = options.tab_view

    @listenTo @collection, 'add', @prepend

  prepend: (model) =>
    list_item_view = new ICRMClient.Notifications.NotificationListItemView model: model, tab_view: @tab_view
    @$el.prepend list_item_view.render().el
    @$el.animate { scrollTop: 0 }, 'slow'
