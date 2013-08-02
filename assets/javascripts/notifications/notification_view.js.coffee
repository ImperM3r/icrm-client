class ICRMClient.Notifications.NotificationView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_view']

  events:
    'click a.close-link': '_close'

  initialize: (options) ->
    @tab_view = options.tab_view

  render: ->
    @$el.html @template @model.toJSON()
    @

  show: =>
    @tab_view.append_view @
    @render().$el.fadeIn(200)

  hide: =>
    @remove()

  _close: =>
    @_markAsRead()
    @tab_view.closeCurrentView()

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

