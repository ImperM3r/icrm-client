class ICRMClient.Notifications.NotificationTabView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_tab_view']

  tab_name: 'Notifications'
  id: 'convead_notifications_holder'

  initialize: (options) ->
    @faye = options.faye
    @parent_controller = options.parent_controller

    @collection = new ICRMClient.Notifications.NotificationsCollection()

    @faye.subscribe "/notifications/#{options.visitor.id}", @_notificationHandler

    @listenTo @collection, 'add', @append

    window.ICRMClient.TestHelpers.SendTestNotificatoin= =>
      @_notificationHandler notification:
        manager:
          avatar_url: 'http://lorempixel.com/32/32/cats/'
        subject: 'Subject',
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"

  append: (model) ->
    model.view = new ICRMClient.Notifications.NotificationView model: model
    @parent_controller.show()
    @button.click()
    @$('ul.listing').append model.view.render().el

  render: ->
    @$el.html @template()
    @

  _notificationHandler: (message) =>
    console.log JSON.stringify(message)
    @collection.add new ICRMClient.Notifications.NotificationModel(message.notification)
