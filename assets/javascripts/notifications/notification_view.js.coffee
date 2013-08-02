class ICRMClient.Notifications.NotificationView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_view']

  events:
    'click a.close-link': '_close'

  initialize: (options) ->
    @tab_view = options.tab_view
    @tab_view.append_view @

  render: ->
    @$el.html(@template @model.toJSON()).fadeIn(200)
    @

  show: =>
    @$el.show()

  hide: =>
    @$el.hide()

  _close: =>
    @_markAsRead()
    @tab_view.closeView()

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
      success: (d) =>
        console.log JSON.stringify(d)
        @model.set('read', true);
      error: (d) ->
        console.error "Error sending mark_read request #{d}"

