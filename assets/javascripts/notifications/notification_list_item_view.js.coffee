class ICRMClient.Notifications.NotificationListItemView extends @ICRMClient.Backbone.View
  template: JST['notifications/notification_list_item_view']

  tagName: 'li'
  attributes: ->
    class: 'popup-section notification-' + if @model.get('read') then 'read' else 'unread'

  initialize: (options) ->
    @tab_view = options.tab_view

    @listenTo @model, 'change', @render

  events:
    'click a.open' : '_showNotification'

  render: ->
    @$el.html(@template @presentation()).fadeIn(400)
    @$el.attr 'class', @attributes().class
    @

  presentation: ->
    p = @model.toJSON()
    _.extend p, window.ICRMClient.Helpers, @
    p

  _showNotification: ->
    @tab_view.showNotification @model
