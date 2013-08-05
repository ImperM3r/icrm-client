class ICRMClient.Notifications.NotificationView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_view']

  events:
    'click a.j-go-back': '_close'

  initialize: (options) ->
    @tab_view = options.tab_view

  render: ->
    @$el.html @template @model.toJSON()
    @

  _close: =>
    @_markAsRead()
    @tab_view.closeCurrentView()
    @remove()

  read_url: window.ICRMClient.Assets.api_url + 'notifications/mark_read'

  _markAsRead: =>
    return if @model.get('read')
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

