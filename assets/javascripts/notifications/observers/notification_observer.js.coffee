class ICRMClient.Notifications.NotificationObserver

  constructor: (options) ->
    _.extend @, window.ICRMClient.Backbone.Events
    @collection = options.collection
    @widget     = options.widget

    @listenTo @collection, 'add', @_showNotification

  _showNotification: (model) =>
    @widget.showNotification model unless model.get('read') == true
