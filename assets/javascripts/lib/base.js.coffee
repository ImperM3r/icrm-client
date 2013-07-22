## Base class

class @ICRMClient.Base
  # Initizializes later:
  # $
  # $rootNode
  # $notificationsNode
  assets:
    window.ICRMClient.Assets

  error: (message) ->
    console.error message

  debug: (message) ->
    console.log message

  log: (message) ->
    console.log message

  ajax: (options) =>

    data = _.extend options,
      headers:
        'X-Convead-Appkey': window.ICRMClient.app_key
      crossDomain: true
      xhrFields:
        withCredentials: true
      type: 'POST'
      error: (e) ->
        console.log "error while making cors ajax: #{e}"
        #throw 'error'

    console.log "Sending ajax: " + JSON.stringify(data)

    # XDomainRequest object is used instead of clean ajax
    # for CORS request in ie8, ie9 browsers
    # https://www.pivotaltracker.com/s/projects/841313/stories/53544883
    if XDomainRequest? && xdr = XDomainRequest()
      data = JSON.stringify(data)
      console.log "Sedning xdr: #{data}"
      xdr.onload = ->
        options.success JSON.parse xdr.responseText
      xdr.onerror = ->
        console.log 'xdr cors request error'
      xdr.ontimeout = ->
        console.log 'xdr cors request timeout'
      xdr.timeout = 10000
      xdr.open 'POST', options.url
      xdr.send data
    else
      window.ICRMClient.$.ajax data
