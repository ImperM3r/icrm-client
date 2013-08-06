class ICRMClient.Notifications.NotificationModel extends @ICRMClient.Backbone.Model
  read_url: window.ICRMClient.Assets.api_url + 'notifications/mark_read'

  markRead: =>
    return if @get('read')

    # TODO send ajax to mark notification as read
    console.log "Mark notification #{@id} as read"

    window.ICRMClient.Base::ajax
      url: @read_url
      data: { id: @id }
      success: (d) =>
        @set('read', true)
      error: (d) ->
        console.error "Error sending mark_read request #{d}"

