# TODO Move views methods to the View

class @ICRMClient.Models.Notification extends @ICRMClient.Base
  constructor: (attrs) ->
    @subject = attrs.subject
    @content = attrs.content
    @id = attrs.id

    @read_url = window.ICRMClient.Assets.api_url + 'notifications/mark_read'

    # Settings
    #
    @timeToClose = 15000
    @timeToRead = 3000

    @_read = false

    @$el = @_prepareHtml()

  _prepareHtml: ->
    el = @$ "<div id='icrm_chat'>"+
      "<a class='close' href='#'>&times;</a>"+
      "<img src='http://lorempixel.com/32/32/cats/' class='icrm_chat_avatar pull-left' width='32' height='32' />"+
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

    setTimeout @close, @timeToClose
    setTimeout @markAsRead, @timeToRead

  markAsRead: =>
    return if @_read

    @_read = true
    # TODO send ajax to mark notification as read
    @log "Mark notification #{@id} as read"

    post =
      type: 'POST'
      url: @read_url
      data: { app_key: window.ICRMClient.app_key, id: @id }
      xhrFields:
        withCredentials: true
      success: (d) ->
        console.log d
      error: (e) ->
        console.error e
    @$.ajax post

  close: =>
    @log "Close notification #{@id}"
    @markAsRead()
    @$el.fadeOut 400, =>
      @$el.remove()
