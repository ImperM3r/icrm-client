class ICRMClient.Notifications.NotificationTabView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_tab_view']

  tab_name: 'Notifications'
  id: 'convead_notifications_holder'

  registered_views: []

  initialize: (options) ->
    @faye = options.faye
    @parent_controller = options.parent_controller

    @faye.subscribe "/notifications/#{options.visitor.id}", @_notificationHandler

    @collection = new ICRMClient.Notifications.NotificationsCollection()
    @list_view = new ICRMClient.Notifications.NotificationListView collection: @collection, tab_view: @
    #show list view
    @showView()

    window.ICRMClient.TestHelpers.SendTestNotificatoin= =>
      @_notificationHandler notification:
        manager:
          avatar_url: 'http://lorempixel.com/32/32/cats/'
        subject: 'Subject'
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"

  activateTab: =>
    @parent_controller.show()
    @.button.click()

  register_view: (view) =>
    @registered_views.push view
    @$el.append view.render().$el.hide() # starting hidden

  showView: (view) =>
    if view == undefined
      #default view
      view = @list_view

    _.each @registered_views, (r_view) =>
      r_view.activate view

  _notificationHandler: (message) =>
    console.log JSON.stringify(message)
    @collection.add new ICRMClient.Notifications.NotificationModel(message.notification)
