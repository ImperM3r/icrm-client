class ICRMClient.Notifications.NotificationView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_view']

  events:
    'click a.close-link': '_close'

  initialize: (options) ->
    @tab_view = options.tab_view
    @tab_view.register_view @

  render: ->
    @$el.html(@template @model.toJSON()).fadeIn(200)
    @

  activate: (view) =>
    if view == @
      @$el.show()
    else
      @$el.hide()

  _close: =>
    @_markAsRead()
    @tab_view.showView()

  read_url: window.ICRMClient.Assets.api_url + 'notifications/mark_read'

  _read: false

  _markAsRead: =>
    return if @_read
    id = @model.get('id')

    @_read = true
    # TODO send ajax to mark notification as read
    console.log "Mark notification #{id} as read"

    window.ICRMClient.Base::ajax
      url: @read_url
      data: { id: id }
      success: (d) ->
        console.log JSON.stringify(d)
      error: (d) ->
        console.error "Error sending mark_read request #{d}"

