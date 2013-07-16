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

  ajax: (options) ->

    data = _.extend options,
      headers:
        'X-Convead-Appkey': window.ICRMClient.app_key
      crossDomain: true
      xhrFields:
        withCredentials: true
      type: 'POST'
      error: (e) ->
        console.error e
        #throw 'error'

    console.log "Sending ajax: " + JSON.stringify(data)
    @$.ajax data
