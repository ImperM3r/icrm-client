# TODO Move views methods to the View

class @ICRMClient.NotificationView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification']

  className: 'notification-box'

  read_url: window.ICRMClient.Assets.api_url + 'notifications/mark_read'

  _read: false

  initialize: (options) ->

    @controller = options.controller
    @noty = 
      subject: options.notification.subject
      content: options.notification.content
      id:      options.notification.id
      avatar:  options.notification.manager.avatar_url

  events:
    'click a.convead_notification_close' : 'close'

  render: ->
    @$el.html @template @noty
    @$el.fadeIn(400)
    @

  markAsRead: =>
    return if @_read

    @_read = true
    # TODO send ajax to mark notification as read
    @log "Mark notification #{@noty.id} as read"

    @ajax
      url: @read_url
      data: { id: @noty.id }
      success: (d) ->
        console.log JSON.stringify(d)

  close: =>
    @log "Close notification #{@id}"
    @markAsRead()
    @$el.fadeOut 400, =>
      @$el.remove()
