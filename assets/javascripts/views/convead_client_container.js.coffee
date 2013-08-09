class @ICRMClient.ConveadClientContainer extends @ICRMClient.Backbone.View
  id: 'convead_client_container'
  className: 'convead-client-reset'
  initialize: ->
    css_file = window.ICRM_Settings.color || 'red'
    window.ICRMClient.Utils.loadStyle "#{window.ICRMClient.Assets.css_root}/#{css_file}.css"

  append: (el) ->
    @$el.append el

  body: ->
    ($ || window.ICRMClient.$)('body').eq(0).append @$el

  injectToBody: ->
    @body().append @$el

    @
