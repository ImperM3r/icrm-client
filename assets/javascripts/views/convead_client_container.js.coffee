class @ICRMClient.ConveadClientContainer extends @ICRMClient.Backbone.View
  id: 'convead_client_container'
  className: 'convead-client-reset'
  color: 'red'
  initialize: (args)->
    args ||= {}

    @color = window.ICRM_Settings.color if window.ICRM_Settings && window.ICRM_Settings.color

    window.ICRMClient.Utils.loadStyle "#{window.ICRMClient.Assets.css_root}/#{@color}.css"

  append: (el) ->
    @$el.append el

  body: ->
    ($ || window.ICRMClient.$)('body').eq(0).append @$el

  injectToBody: ->
    @body().append @$el

    @
