class ICRMClient.Notifications.NotificationTabView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_tab_view']

  tab_name: 'Notifications'
  id: 'convead_notifications_holder'

  initialize: (options) ->
    @parent_controller = options.parent_controller
    @list_view = new ICRMClient.Notifications.NotificationListView collection: @collection, tab_view: @
    @append_view @list_view
    @showView()

    @listenTo @collection, 'add', @activateTab

  activateTab: =>
    @parent_controller.show()
    @button.click()
    @

  append_view: (view) =>
    @$el.append view.render().$el.hide() # starting hidden

  closeCurrentView: =>
    @showView @list_view

  showView: (view) =>
    if !@current_view
      @current_view = @list_view
    @current_view.hide()

    if view != undefined
      @current_view = view

    @current_view.show()
