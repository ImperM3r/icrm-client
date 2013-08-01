class @ICRMClient.Notifications.NotificationView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_view']

  tagName: 'li'
  className: 'popup-section'

  read_url: window.ICRMClient.Assets.api_url + 'notifications/mark_read'

  _read: false

  events:
    'click a.open'       : '_showPopup'
    'click a.close-link' : '_closePopup'

  render: ->
    @$el.html @template @model.toJSON()
    @$el.fadeIn(400)
    @

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

  _closePopup: =>
    @_markAsRead()
    @$el.removeClass 'popup-active'
    @$('div.popup').hide()

  _showPopup: ->
    @$el.addClass 'popup-active'
    @$('div.popup').show()
