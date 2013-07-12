# TODO Move views methods to the View

class @ICRMClient.Models.Notification extends @ICRMClient.Base
  constructor: (attrs) ->
    @subject = attrs.subject
    @content = attrs.content

    @$el = @_prepareHtml()

  _onClose: ->
    (@$el).remove()

  _prepareHtml: ->
    el = @$ "<div class='alert'>"+
      "<a class='close pull-right' href='#'>&times;</a>"+
      "<div class='subject pull-left'>#{@subject}</div>"+
      "<div class='content'>#{@content}</div>"+
      "</div>"

    el.find('a').on 'click', =>
      @close()

    el

  show: ->
    @$el.fadeIn 400
    @$notificationsNode.append @$el

  markAsRead: ->
    # TODO send ajax to mark notification as read

  close: ->
    @markAsRead()
    @hide()

  hide: ->
    @$el.fadeOut 400
