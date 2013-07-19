# TODO Move views methods to the View

class @ICRMClient.NotificationModel extends @ICRMClient.Base
  read_url: window.ICRMClient.Assets.api_url + 'notifications/mark_read'
  _read: false

  constructor: (attrs) ->
    @subject = attrs.subject
    @content = attrs.content
    @avatar = attrs.manager.avatar.thumb_32.url
    @id = attrs.id

    @$el = @_prepareHtml()

  _prepareHtml: ->
    el = @$ "<div id='icrm_chat'>"+
      "<a class='convead_notification_close' href='#'>&times;</a>"+
      "<img src='#{@avatar}' class='icrm_chat_avatar pull-left' width='32' height='32' />"+
      "<div class='pull-right'>"+
      "<div class='icrm_chat_subject'><strong>#{@subject}</strong></div>"+
      "<div class='icrm_chat_content'>#{@content}</div>"+
      "</div>"+
      "</div>"

    el.find('a').on 'click', =>
      @close()

    el

  show: ->
    @$el.fadeIn(400)
    @$notificationsNode.append @$el

  markAsRead: =>
    return if @_read

    @_read = true
    # TODO send ajax to mark notification as read
    @log "Mark notification #{@id} as read"

    @ajax
      url: @read_url
      data: { id: @id }
      success: (d) ->
        console.log JSON.stringify(d)

  close: =>
    @log "Close notification #{@id}"
    @markAsRead()
    @$el.fadeOut 400, =>
      @$el.remove()
