@ICRMClient.Utils =
  currentjQueryIsOk: ->
    return false unless jQuery?
    jq_ver = jQuery.fn.jquery.split '.' # jQuery.fn.jquery returns version as "1.10.2" string
    parseInt(jq_ver[0]) >= 1 and parseInt(jq_ver[1]) >= 9

  loadStyle: (source) ->
    css = document.createElement "link"
    css.rel = "stylesheet"
    css.media = "screen, projection"
    css.type = "text/css"
    css.href = source
    window.ICRMClient.head.appendChild css

  loadScript: (source, callback) ->
    script = document.createElement "script"
    script.type = "text/javascript"
    script.src  = source
    script.onreadystatechange = ->
      callback.call() if @readyState in ['complete', 'loaded']
    script.onload = callback
    window.ICRMClient.head.appendChild script

  preparejQuery: (callback)->
    if window.ICRMClient.Utils.currentjQueryIsOk()
      window.ICRMClient.jQuery = jQuery
      window.ICRMClient.Base::$ = window.ICRMClient.jQuery
      window.ICRMClient.Base::$.support.cors = true

      callback.call()

    else
      window.ICRMClient.Utils.loadScript window.ICRMClient.Assets.jQuery, ->

        unless jQuery?
          console.error "Error loading jQuery"
          return 
        # if there is no previously loaded jQuery versions in stack we are not going to delete exising one
        window.ICRMClient.jQuery = jQuery.noConflict true
        window.ICRMClient.Base::$ = window.ICRMClient.jQuery
        window.ICRMClient.Base::$.support.cors = true

        callback.call()



## Debug logger for Faye

@ICRMClient.FayeLogger=
  incoming: (message, callback) ->
    console.log('incoming', message)
    callback(message)

  outgoing: (message, callback) ->
    console.log('outgoing', message)
    callback(message)


## Base class

class @ICRMClient.Base
  # Initizializes later:
  # $
  # $rootNode
  # $notificationsNode
  assets:
    window.ICRMClient.Assets
  log: (message) ->
    console.log message
