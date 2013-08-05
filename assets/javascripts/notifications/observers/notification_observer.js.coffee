class ICRMClient.Notifications.NotificationObserver

  constructor: (options) ->
    _.extend @, window.ICRMClient.Backbone.Events
    @collection = options.collection
    @widget     = options.widget

    @listenTo @collection, 'add', (model) =>
      @widget.showNotification model
