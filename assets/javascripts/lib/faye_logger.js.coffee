## Debug logger for Faye

class @ICRMClient.FayeLogger
  constructor: (visitor_id) ->
    @visitor_id = visitor_id

  incoming: (message, callback) ->
    #console.log('incoming', message)
    callback(message)

  outgoing: (message, callback) ->
    #console.log('outgoing', message)
    message.ext = {visitor_id: @visitor_id}
    callback(message)
