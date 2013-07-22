class @ICRMClient.ConveadClientContainer extends @ICRMClient.Backbone.View
  id: 'convead_client_container'
  initialize: ->
    window.ICRMClient.Utils.loadStyle '/assets/v1.css'

  append: (el) ->
    @$el.append el

  body: ->
    ($ || window.ICRMClient.$)('body').eq(0).append @$el

  injectToBody: ->
    @body().append @$el

    @
